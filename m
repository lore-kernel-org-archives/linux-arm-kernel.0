Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E76C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:43:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8221D2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AH8xbW5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8221D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uhZF6/5MiGNH72PdMCL5qbndDVoHCTswrd3r13Se7aU=; b=AH8xbW5PZ/0vFw
	evTFpslG//Dcp3RjgTWZXXrDC98H6jb5fLZ40Zh8aBF/EzySh1MJv5yCrAwm64ZskCNmiJ6OIPbsC
	o6nKJWCyNlfmh3ULBkWuoFoAcXeoYZ2o0wau3i3M0/ddu12etZIZBbegT/ThvsHC6IkFHsGhbfOv7
	H3HB3Fbb1rfxuzhRbDlSaZBgf3hHEww3uaZ409TscjZzlIRKjbgmnPA/HGg4P0mbpIwxE16RzISq1
	Ij/0f2w2F4xVikEnM97aX1mfPAKm1a094PUoyvJfOl50GZzIjFn6nq7lZZp/WIGZnehNueIGOx5wx
	QJhbijW1mOLTPu3WtX9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grT6U-0004nd-5U; Wed, 06 Feb 2019 19:43:26 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grT5G-0003Wo-26
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:42:19 +0000
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id D5CA7100008;
 Wed,  6 Feb 2019 19:42:02 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 6/7] clk: sunxi-ng: sun5i: Export the MBUS clock
Date: Wed,  6 Feb 2019 20:41:23 +0100
Message-Id: <631521f362904022dd3a1b7a7d3d90c572773e49.1549482066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
References: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_114210_618321_232EACC0 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 dri-devel@lists.freedesktop.org, Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yong Deng <yong.deng@magewell.com>, Robin Murphy <robin.murphy@arm.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MBUS clock is used by the MBUS controller, so let's export it so that
we can use it in our DT node.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/clk/sunxi-ng/ccu-sun5i.h      | 4 ----
 include/dt-bindings/clock/sun5i-ccu.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.h b/drivers/clk/sunxi-ng/ccu-sun5i.h
index 93a275fbd9a9..b66abd4fd0bf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.h
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.h
@@ -60,10 +60,6 @@
 
 /* The rest of the module clocks are exported */
 
-#define CLK_MBUS		99
-
-/* And finally the IEP clock */
-
 #define CLK_NUMBER		(CLK_IEP + 1)
 
 #endif /* _CCU_SUN5I_H_ */
diff --git a/include/dt-bindings/clock/sun5i-ccu.h b/include/dt-bindings/clock/sun5i-ccu.h
index 81f34d477aeb..2e6b9ddcc24e 100644
--- a/include/dt-bindings/clock/sun5i-ccu.h
+++ b/include/dt-bindings/clock/sun5i-ccu.h
@@ -100,7 +100,7 @@
 #define CLK_AVS			96
 #define CLK_HDMI		97
 #define CLK_GPU			98
-
+#define CLK_MBUS		99
 #define CLK_IEP			100
 
 #endif /* _DT_BINDINGS_CLK_SUN5I_H_ */
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
