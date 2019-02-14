Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C8AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:19:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB2D222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZ383tCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB2D222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=29dtnQMZ60zTITwAK9eQobkjXag1MUkn48hVp9JkBsY=; b=KZ383tChirmJCR
	+bET6CimbZgt5vhf1A+NiiarFDUrslrgmw6TbA7sqDdEbr0za35BND+YnXaXCobmSCBLzYF9tnh3X
	PmF4f66FDxtEYhQUAeZSGTyIVlM/HzyhA/mP4qNDrGJEgh3fb+iScg5KKkVwW/Rb9hm7lKCSDCl2C
	lvO4ovhvAX5Q2rLsl51IGspEij16ap3WHThiQJ2ExeXsUr/Tok3/wlICYhaT4Cnx/4bXpDwQKITnq
	cFYoTzC+JhkMwbj9UV1qRBQh/NLgO9/x96d2izQPy8XCNlzywSoUaPCuReqvLXOkUFs4k13qP0w4F
	8Ov4ggujodJXWCcpJejw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4kN-0006x5-Im; Thu, 14 Feb 2019 00:19:23 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4kJ-0006wi-VW
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:19:21 +0000
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net
 [96.89.128.221]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FF1514BA2BEB;
 Wed, 13 Feb 2019 16:19:13 -0800 (PST)
Date: Wed, 13 Feb 2019 16:19:12 -0800 (PST)
Message-Id: <20190213.161912.1056928506839061227.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next 0/4] net: phy: Add 2.5G/5GBASET PHYs support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 13 Feb 2019 16:19:14 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_161920_018735_9260414B 
X-CRM114-Status: UNSURE (   7.96  )
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
Cc: andrew@lunn.ch, f.fainelli@gmail.com, antoine.tenart@bootlin.com,
 netdev@vger.kernel.org, gregory.clement@bootlin.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, hkallweit1@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Mon, 11 Feb 2019 15:25:25 +0100

> The 802.3bz standard defines 2 modes based on the NBASET alliance work
> that allow to use 2.5Gbps and 5Gbps speeds on Cat 5e, 6=A0and 7 cables.
> =

> This series adds the necessary infrastructure to handle these modes with
> C45 PHYs. This series was originally part of a bigger one, that has
> seen 2 iterations [1] [2] that added support for these modes on Marvell
> Alaska PHYs.
> =

> Following some discussions with Heiner and Andrew [3], we decided to
> split-out the generic parts so that we can work together on the
> following steps to get these mode fully working with Aquantia and
> Marvell PHYS.
> =

> The first 3 patches are reworking some of the internal network phy
> infrastructure to handle the new modes in a more generic way.
> =

> The 4th patch adds all the C45 register definition and accesses that
> follows the 802.3bz standard to support 2.5GBASET and 5GBASET.
> =

> [1] : https://lore.kernel.org/netdev/20190118152352.26417-1-maxime.cheval=
lier@bootlin.com/
> [2] : https://lore.kernel.org/netdev/20190207094939.27369-1-maxime.cheval=
lier@bootlin.com/
> [3] : https://lore.kernel.org/netdev/81c340ea-54b0-1abf-94af-b8dc4ee83e3a=
@gmail.com/

Series applied, thanks Maxime.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
