Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:22:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D0A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="trSCARrX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNPy61wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pTefHB4ekdfh61uEZLeK8dKGHAZRUeCMt5OZMODzYnU=; b=trSCARrXZDJTX/
	XvZwC6ecgAVFDc2/f18uZ3mzOTKCdJ1VSJL8UW+n3LGQHbwejaQMRLEG008UAZK3XNjGIkAJo1Pxj
	vQvOAu2moLK7dtObwJ4rB5eIQww5p1URLJTB23L2U+SZmP/i14ZJuDDaMU0FWy5oKYqNRWZvA3FhH
	PzxleT3I8bf8hKoIkDHAjSVLCQXMZ/a7ZRN5tQFma5/jcRAT6KpALt7nCj2XpFsWZOr4SOMpgof5J
	X8xbw9I+Tii6yVAGGYZ3fKuld/sJTn5/7EUIgFIhAnszcbxKQ/kXTjWkGiswPUgvbVA41+AJwY1Cb
	/3ye8YXbVK+ToreFGDhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghaHy-00011r-EA; Thu, 10 Jan 2019 13:22:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaHv-000118-C3
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:22:24 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2235D214DA;
 Thu, 10 Jan 2019 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547126540;
 bh=OECq5171S9i76LcX8GhY6qNZdz8TO45DCOI9JThXBnQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QNPy61wYrXLXZlpLNsrTlouHOgDXHM5NTaWfwCrMjLfVYE80q3alIGubwnpzYd4t0
 38zAinaCBPmKZUVSBR+ohKU7C11k8PHPQbSzFOa3OF+fdKu5QXgK2tFl9XSAp9XDvE
 d3aMO6c3peTcD2oWmpLuoDOtkYyrZahT5jFieWRA=
Date: Thu, 10 Jan 2019 21:22:10 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2] ARM: dts: vf610-bk4: Provide support for reading ID
 code from MVB device
Message-ID: <20190110132209.GA30487@dragon>
References: <20181113121213.14296-1-lukma@denx.de>
 <20181209215056.22027-1-lukma@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209215056.22027-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_052223_427945_C024F21C 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 10:50:56PM +0100, Lukasz Majewski wrote:
> The procedure to read this ID value is as follows:
> 
> rmmod spi_fsl_dspi
> insmod spi-gpio.ko
> 
> echo 504 > /sys/class/gpio/export
> cat /sys/class/gpio/gpio504/value
> ...
> echo 511 > /sys/class/gpio/export
> cat /sys/class/gpio/gpio511/value
> 
> rmmod spi-gpio.ko
> insmod spi_fsl_dspi
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
