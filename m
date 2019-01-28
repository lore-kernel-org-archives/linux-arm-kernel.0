Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486ECC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:55:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1868921738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5ZBUidK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1868921738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kQ8YmlfOIKat4TdkAuxz6aLybHs8C2X/W1Q4Tjj25C4=; b=V5ZBUidKoHGfOx
	NK2psNnHqHgzFpnYEwIdF21VdJ3a8D1eqsqtmNijljSIIeicMVPgEaHQyyhnycfk3pG7eltjvbSJP
	xn1L4ZmaCSZ5/xKzxjRI9DFbiIBFdHzrRiZogTqy4/+sn4QLsOIciNFfn/IEO3JXw/icuKeAkByhI
	7no+JCByLvCM3jUzlbE5lBj0cmumCcWI4RENg04/hi692rw9oHz3Rg+R+9y4vuojrQbQxKWBg4/hF
	8wh1JGJLBcFuEvG4zipGwSBKHvmAS411enREcSnPWLYug7G1LaawzkoEe1whX6/oVuoNypcmn0oQw
	WbDYASloMW7AIIHZPvhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goDwG-0008UH-SE; Mon, 28 Jan 2019 20:55:28 +0000
Received: from mailoutvs51.siol.net ([185.57.226.242] helo=mail.siol.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDwD-0008Rt-CO
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:55:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTP id A05C0521E13;
 Mon, 28 Jan 2019 21:55:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id QIsLjbqUufl8; Mon, 28 Jan 2019 21:55:17 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTPS id 59D8D521CC1;
 Mon, 28 Jan 2019 21:55:17 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Zimbra) with ESMTPSA id D3E8A521849;
 Mon, 28 Jan 2019 21:55:12 +0100 (CET)
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com,
	wens@csie.org
Subject: [PATCH 1/6] dt-bindings: media: cedrus: Add H6 compatible
Date: Mon, 28 Jan 2019 21:54:59 +0100
Message-Id: <20190128205504.11225-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128205504.11225-1-jernej.skrabec@siol.net>
References: <20190128205504.11225-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_125525_591622_990015A2 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, robh+dt@kernel.org,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a compatible for H6. H6 VPU supports 10-bit HEVC decoding and
additional AFBC output format for HEVC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/media/cedrus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/cedrus.txt b/Documentation/devicetree/bindings/media/cedrus.txt
index bce0705df953..20c82fb0c343 100644
--- a/Documentation/devicetree/bindings/media/cedrus.txt
+++ b/Documentation/devicetree/bindings/media/cedrus.txt
@@ -13,6 +13,7 @@ Required properties:
 			- "allwinner,sun8i-h3-video-engine"
 			- "allwinner,sun50i-a64-video-engine"
 			- "allwinner,sun50i-h5-video-engine"
+			- "allwinner,sun50i-h6-video-engine"
 - reg			: register base and length of VE;
 - clocks		: list of clock specifiers, corresponding to entries in
 			  the clock-names property;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
