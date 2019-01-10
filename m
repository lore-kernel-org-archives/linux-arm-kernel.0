Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DBCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:56:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869E6214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oUHKT8C9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W320BZeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869E6214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oxspKxpcckZo3+ooJ8sQymrAToyMyC/WyfepTSOfFP0=; b=oUHKT8C9e14dEe
	4jhjw+GCSSqg5x2HwugvB1iccCaEQWv4wBDpnAVJ9hQaRldRmSOUdxcy2bTvWS8/NV4sOMMKTex2E
	xTcRR0LS3Iop5/CZxeSTZgiYh4FW3HbWEsYVIzif/KeGUnRDpKnt7RHt9mHqKDGQG+Ti0OGSoHG0o
	jIvA2NVe8rXVNuZTJAb603jRBtiZ0cLrIjqqCh5zRr3CQ3WTNrIgBU4XSf75ntv3WHjbetEMlEYbd
	yC/DunLHGLF92Ityex4HV3ozUqL7eOICjuAvsbUdIJtVToFOnhq3cRc1cfaUbj3sb0Zl1QMvjfSBb
	4AYbtbB3x08TmxN+EQww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZsU-0007ne-N2; Thu, 10 Jan 2019 12:56:06 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZsQ-0007h7-Mr
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=ZIAvV0zR0eRizhTOOTKm5wGrDQOa6TGlyppv2iYDJWM=; 
 b=W320BZeBRcAL0ry42PGNMQtTQZ6QDxQg5SFxQxuYkUcEWDXeJ5lzP0vJ/yvOOGNI0D/o7vUwsthkZPGgUU5htxpwu/qkd/TZbq1+5nPaXn8UryxoUylGo/OMzfntrpymji2y0yLXA2cU/brPZaSHGDzLcX0BopccwM6eRzSpgYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1ghZsC-0001Yr-Bd; Thu, 10 Jan 2019 13:55:48 +0100
Date: Thu, 10 Jan 2019 13:55:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Message-ID: <20190110125548.GA29612@lunn.ch>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_045602_925669_5EABDC90 
X-CRM114-Status: GOOD (  11.42  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pwm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 02:26:22PM +0200, Baruch Siach wrote:
> Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
> signal") added reset signal support. Reset is unconditionally asserted
> and deasserted.
> 
> Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
> NIC is in the PCIe slot.
> 
> It turns out that you can toggle the reset signal only once. Another
> reset signal toggle makes access to PCI configuration registers stall
> indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
> boot.

Hi Baruch

Is this double reset issue limited to just Mellanox NICs, or any
device in the PCIe slot?

This sounds more like a workaround than a fix. It would be good to
investigate further and determine which end of the PCIe link has the
problem.

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
