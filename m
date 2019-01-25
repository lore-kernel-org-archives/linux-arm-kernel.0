Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4647CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:06:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BDE218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZ3mGRKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iPeFP3G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BDE218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kf2qNBk7Xobo/5hlnzN4QD7Kg00L1bh03Z3s9LYZpBc=; b=OZ3mGRKmRAdtEy
	i+r8QWJtwqRX4XKU2DXYaGfT47iEO643VTC73HcgpwV/9tmu9ylbaAUjas6jMnF9yh59cM4LYwhQV
	2l7wfCSZ7ZjqmBqjT69RMtnNBsz79dMOeCiVhLnv8ylUhTE7qaQa6dJ5O/p6Kvlfb3hm0iZgWJd0K
	vtDKb2V5ObG7ZPYKl1RjJnVNfNy6Uu5rQoGrt0KpxBEEA6GOHgbTgg/sjzsMS6gTEWpYEuB+nQIFB
	yJVyLyenEX5An34PKvIJdaga8pjQ/7HETCqIXUFfVhFUI2L5wcP+xNd+ox8V4iRUikFK+eb3/ZU/L
	EaWMG9J31mcNJ1X6bI5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5rv-00052c-Hx; Fri, 25 Jan 2019 18:06:19 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5rr-00052A-U7
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n46IukVJ69fo7pjc4+MGmLxT8EA6jo8+s3B+Lj2LzKc=; b=iPeFP3G6491/K5fpmSUZq1UjVW
 ztph4F2tNhMYNvromOsinm/dlBcY3RB3cexLAM2wqWHChrXWnAibv6qYf9n/y+0hlGAoLgxxwXREK
 gbA7tRMSHEIufQY+5eMKD/a8niOShrPWI0rlYm/Dcft+eMqjzZHI9QBJCuko5BEuDPDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gn5rc-00069G-NO; Fri, 25 Jan 2019 19:06:00 +0100
Date: Fri, 25 Jan 2019 19:06:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH v6] arm64: dts: marvell: Add device tree for uDPU board
Message-ID: <20190125180600.GE22211@lunn.ch>
References: <20190125171707.27742-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125171707.27742-1-vladimir.vid@sartura.hr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_100616_123316_31486005 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: devicetree@vger.kernel.org, Luis Torres <luis.torres@methode.com>,
 Jason Cooper <jason@lakedaemon.net>, Paul Arola <paul.arola@telus.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Scott Roberts <scott.roberts@telus.com>, Luka Perkov <luka.perkov@sartura.hr>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 06:17:08PM +0100, Vladimir Vid wrote:
> This adds initial support for micro-DPU (uDPU) board which is based on
> Armada-3720 SoC.  micro-DPU is the single-port FTTdp distribution point
> unit made by Methode Electronics which offers complete modularity with
> replaceable SFP modules both for uplink and downlink (G.hn over
> twisted-pair, G.hn over coax, 1G and 2.5G Ethernet over Cat-5e cable).
> 
> On-board features:
> - 512 MiB DDR3
> - 2 x 2.5G SFP via HSGMII SERDES interface to the A3720 SoC
> - USB 2.0 Type-C connector
> - 4GB eMMC
> - ETSI TS 101548 reverse powering via twisted pair (RJ45) or coax (F Type)
> 
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Luis Torres <luis.torres@methode.com>
> Cc: Scott Roberts <scott.roberts@telus.com>
> Cc: Paul Arola <paul.arola@telus.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
