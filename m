Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D527C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:14:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5713F2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ooKCEAvy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="iacfa+i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5713F2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vhP1+K1F9V8Wjzx5UWyodp4Tmuh4o5Bmbm3+5ZXZDUM=; b=ooKCEAvyJh6ra9pA5VmCpwcUou
	bLp90/kCjm+DANA+wDTxY6PYDR/LCyb5+epmCKxiFGScMc5/Mc2ZxqkJu00jEkn/5hJ5DXWPmiR0L
	LAgDMugM4THyW3mOLsOiFM6f0H1bGJe6QolGg/le0rbE5TtduKt73NRDAP2FQK672HhEJOCj7oxlC
	F+/bU/wD2mvqih+1sSoypp1AkIWTFnaBySPdjKmc2sAe/oHO1GKQd9yokiuhhuu0XIk0ov6+vadEw
	ZsLt6RO6unWjET+gyq0loh9voIKKvzgrmusj2tRMt38tm8dDNU+zKZn8ujyp/+goWhm3Y3yiPFZjl
	FzzLox3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmghp-0001yw-7a; Thu, 24 Jan 2019 15:14:13 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmggw-0001GQ-Rs
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:13:29 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1E08B25BEB4;
 Fri, 25 Jan 2019 02:12:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342761; bh=iVWf0KpRtov/5d40SGLbSVkocQPbmY2btGB49rtcvFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iacfa+i76e0hZWEotkQkEzbr+icEmaMqHhYG64PTFD1HjYHaocygzM+COUD116NWN
 4snbj4NvLTH/5vFZQ8QXTmk9FZ73u1VJQUsrMYZrvSQOatGxubfOCS8WI8jidQULA7
 aEZ6DWG6PXPi0w3/KyQxavGs1yu/a63BaJCT3pA0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 44D0B940421; Thu, 24 Jan 2019 16:12:39 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 02/44] arm64: dts: renesas: r8a77995: draak: Set better
 backlight levels
Date: Thu, 24 Jan 2019 16:11:56 +0100
Message-Id: <a06ad4385f180b476ceca811a60ba00f3f65c12e.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071319_179029_C4173985 
X-CRM114-Status: UNSURE (   8.91  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The backlight levels provided in the Draak DT produce a perceived
brightness very biased towards high brightness. Use better brightness
levels based on the CIE 1931 formula.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 89df9bc844c0..db2bed1751b8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -28,8 +28,8 @@
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 50000>;
 
-		brightness-levels = <256 128 64 16 8 4 0>;
-		default-brightness-level = <6>;
+		brightness-levels = <512 511 505 494 473 440 392 327 241 133 0>;
+		default-brightness-level = <10>;
 
 		power-supply = <&reg_12p0v>;
 		enable-gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
