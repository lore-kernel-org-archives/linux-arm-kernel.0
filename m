Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:09:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5DF217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L2RPKKq+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="XzVO3cxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5DF217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aLnKrsfpuLbkMavrPLUeF8JvdovceBvon5bTcFcCZPc=; b=L2RPKKq+GotA0i
	Rnu/8P9U9r39EJS6ThnCVL2Tme8+QCX/gEZNVNhRiz/OTIG8yos29DesgL1UZLZ5NAl9hHEnV0gHp
	tTnwcLWrOYX7u2t9UeDEgVl6lymelUf78aVudzuUKzTXuCGY596ZF4QmslWGZKH4HcOFMH5mi/mfr
	4ptoP26ZV3RZ5Qn8FoNEJCp2R0FqrJf99rk3z63+D6OQGaZPLppDJcdesg7NRRvo+VquHPnflw+5v
	xVulB7CyTQx7UNSZeU2+S5KVqnpUpqKPavAWG8Eas59umICFHZ1CkdY5HsRLqMRTorZEQNeUyJ69h
	cxAWVDAUVWleOGA46Qmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZF86-0007Vo-6q; Tue, 18 Dec 2018 13:09:46 +0000
Received: from mail.nic.cz ([217.31.204.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZF81-0007UR-8Q
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:09:44 +0000
Received: from localhost (unknown [172.20.6.218])
 by mail.nic.cz (Postfix) with ESMTPS id E7EF260255;
 Tue, 18 Dec 2018 14:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545138565; bh=OhFgmvl1ZsheA1tyLTkSU9tM0Ug0GqJTwPx73mVAwMg=;
 h=Date:From:To;
 b=XzVO3cxW+uEC1Ewg07PZpaZRswgCTBe+CIY8TFOxOLeNQ5vv+9z0fw8LEHRwj+qem
 rTofkzzmx3hfKxg6EvR7m6haOInkotv0CaLSt90yr8H05YqAf5QLyhkCGo0nJG8lQA
 Ls6JaKnj++97Y6goGTlPJkdhX/ipFno/a8Hxq5g8=
Date: Tue, 18 Dec 2018 14:09:20 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181218140920.6935db39@nic.cz>
In-Reply-To: <20181218092314.725af970@xps13>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <20181217223430.182d01d8@nic.cz>
 <20181218091817.4a8a5d42@xps13> <20181218092314.725af970@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_050941_458154_FE2BF3F7 
X-CRM114-Status: UNSURE (   7.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> [2]
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/drivers/marvell/comphy/phy-comphy-3700.c

Yes, I used mainline atf (it did not work out of the box with 18.09
atf-marvell of course). But there is no _power_off function for SGMII,
nor a digital_reset function like in cp110 implementation.

Marek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
