Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5BFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241C1206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="faYS3rVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241C1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OxFvB6M5wNfLmvED9KxB/BcKNIEHYzcqxyojuHuDTlM=; b=faYS3rVAy+fCZ6
	4s8DJ53sWQlTCV99uZenEVRjx1H3xINoVsxsaUMYbSIUmvvyGBWY02Yk8Gc5snA1lg5eipPwWenNa
	RfRHd1zkfiOD8eFP+fZvgyKaTNmRA3dZc65zCgEJ6vMK8C/ejU1Q1FOBDG30yIfuACJbBJCDDOpSr
	lZrttM8rLvkX99PpAC0thQxSOQuB+vmV/6ui9eB/K+lDnZvqV/hUtAwq2HBNpr30jC7sHwLcgKtGV
	TqFbh4/Iy3fhTdVrbvuKhvnwdhe6TPZFKXpumkpALBM80yyEWh32jNR5gZzGMiEHAmgdKEKW/SJBb
	nNY0XQHqmi3DAMnMUzDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxHhh-0007lQ-Hs; Fri, 22 Feb 2019 20:45:53 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxHhe-0007kw-00
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 20:45:51 +0000
X-Originating-IP: 86.201.231.99
Received: from bootlin.com (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr
 [86.201.231.99])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C1B2B1BF208;
 Fri, 22 Feb 2019 20:45:33 +0000 (UTC)
Date: Fri, 22 Feb 2019 21:45:32 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
Message-ID: <20190222214532.2a2cc880@bootlin.com>
In-Reply-To: <a69da540-fe5c-e9a7-d848-2f2c61011f21@gmail.com>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
 <20190221095128.28188-2-maxime.chevallier@bootlin.com>
 <a69da540-fe5c-e9a7-d848-2f2c61011f21@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_124550_190373_FE9039E5 
X-CRM114-Status: GOOD (  10.76  )
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
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 19:42:29 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

>After my just submitted patch to include the aneg capability checking in
>genphy_c45_pma_read_abilities() function mv3310_get_features() isn't
>needed any longer and can be replaced with the generic one.

I'll still need it to handle the 2.5G/5G abilities that aren't
correctly reported on 3310. I'll be able to use the generic
function for the 2110 though, which is nice.

>But we can make this change afterwards, then you don't have to
>rework your series.
>
>Also I'm not sure whether there will be a 5.0-rc8 or whether beginning
>of next week we'll see 5.0. In the latter case we're a little bit in a
>hurry because the merge window will start very soon.

OK, I'll re-spin the series quickly with the small cleanup needed if
everything's OK to you regarding the rest of it.

Thanks,

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
