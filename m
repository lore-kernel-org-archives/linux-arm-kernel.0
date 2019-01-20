Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F496C26641
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:10:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A89F20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CKebdb81";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f0/sDciu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A89F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kkFttmKbIB6XlkMVChZoQWWUbPJ9n/I9oKQxkbX+f7U=; b=CKebdb81k+VC0f
	PCfoHU3mliXaakd8+xoz3FoWyF7wNkW1MBQFQMCHKI/GphbW6rzWTfBNdjBx+8535VPkxs7BRmoyE
	XFqldz8IUY6tKoR9TWnxv0B3hBNy/82UwGS5I9IAqPtta159qIb+AvmqaJnGNUWd+Mm0HH0wsC5gS
	hQoUg5R1AF2RWiNqI8HVawuUBSSaPEjJu88R1/2srvkVdJLVGtETTpywz1OexlnSBWEdDuEwN05S+
	nLledTqHjKhQi3OV62GKxa6xGNtkSwtttuNutnhlFezzCEoBPxXJdazgEKyE2aWEwyJg90pm/ezW1
	ypZouPQ/2ZW9f8a47X4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glIUe-0005nM-H1; Sun, 20 Jan 2019 19:10:52 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glIUY-0005mx-JM
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 19:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=sCZd3JDj+IRIBM6px7DZ1fcglyVLb6KVNDu+/y1vdmk=; 
 b=f0/sDciudAAjM+x7vN6xgucV36a2FWyLnf1eKJNLGrIpbl78vLwHLRaD9dG1gpcJU9H5/ttZkSkAysAxB0hfaGzBkTe6DGMBjNZpNwSeayVCgyrKoJ5ggsfZFOIte8CPeNqkTdAkO1jXrBkG2ZLcyiGeDFUuz/znFN8vjF8ZMqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1glIUT-0005Ky-Fk; Sun, 20 Jan 2019 20:10:41 +0100
Date: Sun, 20 Jan 2019 20:10:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 7/7] net: phy: marvell10g: add support for the
 88x2110 PHY
Message-ID: <20190120191041.GC19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-8-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_111046_924152_5A22EF95 
X-CRM114-Status: UNSURE (   8.88  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +	/* Make sure we advertise all the supported modes, and not just the
> +	 * default one specified in the driver's .features.
> +	 */
> +	linkmode_copy(phydev->advertising, phydev->supported);

We need to look a this. This is something the core should be doing.

   Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
