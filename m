Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049CFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:32:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2C42147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0haLpvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2C42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x7WdOcIjBRNYvgkvWOsE4E3ef5KibbG0KTTRj0u1dH8=; b=M0haLpvOEvTyw4
	QU5SFB25o5cvCRcWmej65uU5wktYFRY5N9mcEVks51gVRnocyVpE9HSTMyqIo9GyoZ1AE2dzy5yIP
	5bc+g04wGYEzf7RvjTLT7BTprdCRph7Bhgk56Z38e4IktBHzCSLvksDb+za3f+Y2f1kcLxo8tPNI6
	8+TTR/aypzntA4X5Ro+IUOmipjIKh4tG8ym6jc88fn3YesFPtySOQ15LhaTBINnPkaATJwtKRZr0Y
	MD+P69LEUm4kGEISR3uBrvplBNEIweNutQRHKVHPcuT/qnYZxMGBqDp7YmU5+5dcknFvJeSXwbErm
	AU/UgF5lDAKToRaJZhUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgyO-0003bK-ND; Thu, 07 Feb 2019 10:32:00 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgyK-0003Zw-Pw
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 10:31:58 +0000
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8ED7210000F;
 Thu,  7 Feb 2019 10:31:47 +0000 (UTC)
Date: Thu, 7 Feb 2019 11:31:46 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: Re: [PATCH net-next v2 01/10] net: phy: Update PHY linkmodes after
 config_init
Message-ID: <20190207113146.4a033fd4@bootlin.com>
In-Reply-To: <20190207094939.27369-2-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-2-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_023156_986620_67B03235 
X-CRM114-Status: UNSURE (   7.52  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello everyone,

On Thu,  7 Feb 2019 10:49:30 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

>We want to be able to update a PHY's supported list in the config_init
>callback, so move the Pause parameters settings from phydrv->features
>after calling config_init to make sure these  parameters aren't
>overwritten.

I realised that I did not include updating the modes according to the
limitations imposed by of_set_phy_supported in this series. If there's
a speed limitation set in the DT, it could be overwritten by
config_init.

I'll respin the series with this addition, sorry about that.

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
