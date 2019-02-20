Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E93C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:39:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5666320880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GcemCz27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5666320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kollasch.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iYfvwyRkwE4FkXv3uLgVPzRIYOIsCM8ifxyhzkJWH3E=; b=GcemCz27QnvhkXtHOR6qYW/TAO
	et8T5m2tfgBks0v0gPHhhqL4dvtmPUW6lhway3yTR1uSaboETytOHzwmHjsxbV3Hl2XlAxDmlH7cl
	0jjb0L8+oZCFMzpgmb5dWKKBEvgbCCUH2OinSB6/0URns5Ns4kUKvMMrEwuAALpBg8/RkytYkb/cB
	jfeBGroHUPw7wRwm7Ax4Gm5OnogCnOZc5BW4fRHhof/zgAG3ygMHfn3bTkU1K7F8fu9ay/FFnpqMM
	COox7M7ZPR6NwfDAJjqFs+XMHrvUEfWcRwS53vwQCxqtqhhbbHvBraa5e5Q+nfGo7q2duNAMs7jPq
	0ZP27N1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTy2-0008M3-CI; Wed, 20 Feb 2019 15:39:26 +0000
Received: from poghril.kollasch.net ([2605:2700:0:3:a800:ff:fe44:639c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTxy-0008Lf-M0
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:39:24 +0000
Received: from mail.kollasch.net (mail.kollasch.net
 [IPv6:2001:470:c003:410:0:454d:4149:4c30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.kollasch.net",
 Issuer "kollasch.net postmaster CA" (verified OK))
 by poghril.kollasch.net (Postfix) with ESMTPS id 493F71FB;
 Wed, 20 Feb 2019 15:33:35 +0000 (UTC)
 (envelope-from jakllsch@kollasch.net)
Received: from terminus.kollasch.net (terminus.kollasch.net
 [IPv6:2001:470:c003:410:3697:f6ff:fe00:7027])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jakllsch@KOLLASCH.NET)
 by mail.kollasch.net (Postfix) with ESMTPSA id AD4491C17B;
 Wed, 20 Feb 2019 15:33:33 +0000 (UTC)
 (envelope-from jakllsch@kollasch.net)
From: "Jonathan A. Kollasch" <jakllsch@kollasch.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: dts: allwinner: fix status LED on nanopi-neo-plus2
Date: Wed, 20 Feb 2019 09:33:03 -0600
Message-Id: <20190220153303.32081-1-jakllsch@kollasch.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180703132636.21587-1-jakllsch@kollasch.net>
References: <20180703132636.21587-1-jakllsch@kollasch.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_073922_724887_E32F9BA6 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: "Jonathan A. Kollasch" <jakllsch@kollasch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The schematics[1][2] for both versions of the NanoPi NEO Plus2 place the
STAT status LED on GPIOA10, and describe it as being a blue LED.

This change makes the blue status LED on my v1.0 board functional.

Signed-off-by: Jonathan A. Kollasch <jakllsch@kollasch.net>

[1]: http://wiki.friendlyarm.com/wiki/images/8/86/Schematic_NanoPi_NEO_Plus2-v1.0-1704.pdf
[2]: http://wiki.friendlyarm.com/wiki/images/b/bf/Schematic_NanoPi_NEO_Plus2-v1.1-1805.pdf
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 506e25ba028a..b8eb43a0d007 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -71,8 +71,8 @@
 		};
 
 		status {
-			label = "nanopi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			label = "nanopi:blue:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
