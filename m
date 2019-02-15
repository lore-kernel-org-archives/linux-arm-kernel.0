Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:56:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E945221A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MW0K1fVW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JlHCeoes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E945221A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8QtIw8Kv7zazusxO9u5L+Ay3x6fvTr2+nH2+/IZmaus=; b=MW0K1fVWtkWLE1
	ngY6WJG0ZAXmjixjctNWweljTsl+0m2htZ6WvmbvqNmajAvRdBrI+YpPS+bcc/E41x6TX3hMIK4uj
	iNZhjTARNywlUyUBaCPULIWGhc+8GuvanC5dxr3OGRQPahQXmoENRQOeMo9Cv25SQf8m6BKwQzTiH
	GkaTdryzfQ0cpH15ZFHFg9NSU58FAmjVtv/hH2qMQnfsiHJI0Tmq7kZR4fe+9Bpv4AuVJnme8Z/WS
	6hxuRn2LTtrEKJGqYY7xFMDpQuYQpUnYqH3usMl7HK7biE50MI6FYGpGZ3AWUUWT+N1JOznuaAwZZ
	AI96Ji3i//N26J8g46sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueuk-00023m-KC; Fri, 15 Feb 2019 14:56:30 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueuh-00023V-71
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dldtYif/dX4XCSUDkPWXBJDWGjlPLsUwDCWthZFiG6Y=; b=JlHCeoespOqqUOfLvCEu1kKpkX
 05Mc1JrJoCAjbdk8EYDIM4NJRC1OOH7/RWihzOaqM96/zV1qvnnLqm5Nir4n6T9poZJLCuj0qn7/o
 MlPPOpFT/Q2QoXFBUOuTNMdAiiUV3pHbxJ/r6tGxs0eSij890yLAf+L7pH25D05iikRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gueub-0006YJ-FN; Fri, 15 Feb 2019 15:56:21 +0100
Date: Fri, 15 Feb 2019 15:56:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [PATCH net-next v2 3/3] enetc: Add ENETC PF level external MDIO
 support
Message-ID: <20190215145621.GO708@lunn.ch>
References: <1550225414-12125-1-git-send-email-claudiu.manoil@nxp.com>
 <1550225414-12125-4-git-send-email-claudiu.manoil@nxp.com>
 <20190215133459.GH5699@lunn.ch>
 <VI1PR04MB488080895C871B6B3ABA571D96600@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB488080895C871B6B3ABA571D96600@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_065627_407714_F1A61D1A 
X-CRM114-Status: UNSURE (   8.07  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alexandru Marginean <alexandru.marginean@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Hi,
> I don't really see what bindings would need to be documented, as the node
> names and properties used so far are common.  Like, the "mdio" node name
> is common, the enetc ports are "pci" nodes, nothing special for these.
> What's missing?

Hi Claudiu

It is not well defined where to put phy nodes. Some drivers do allow
them directly in the MAC node, some drivers optionally allow an mdio
sub-node, others enforce an mdio sub-node. The name of the sub-node is
also not well defined.

So just documenting that the mdio sub-node is mandatory will help
people writing device trees for their boards.

       Andrew



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
