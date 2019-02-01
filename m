Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67682C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:00:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30416218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s0VSfpTw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rkoCGCSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30416218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mlPHP5kHHeaSlrMXF1KuGn7jZj+YHiZQQwT3+mi543E=; b=s0VSfpTwLdrxDM
	/ONTqaxGhtBnyWyWx+qSVfEV/HH4jv/S7PB24kJAiAUcc1p1PuDZcaGPqFU6k/YMpLuzEQ60660HY
	PhDnTI/i/HzFhX84ouG/qyymsvy7YIx6+uOXnmcMGnVgeZdSyk/SfT/aWJttwMXCEpUDj/DUymFd1
	mlcRbNYsQe79eWpJu9dsiMIJUvgkqzhQ1hOZc4ZPW+mvulP/th6Rr16rf2NDMAT6SOpwlLLkvLMfS
	7kuKFUsuIZZR5xbzRViOVMre1xUukeT7KN3HZhZaZt+BNphyiXBpYhoTj5GQeMQHag8jI0OIcEMDz
	coqZipohNS3V3ZfdgYTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYQL-0006aU-Fg; Fri, 01 Feb 2019 13:00:01 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYPJ-0005Sk-0m
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:59:22 +0000
Received: by mail-wm1-x342.google.com with SMTP id b11so6043243wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iWoWhHbCCpEvLIEcPxGwRrtxC+U9ERYPozD4RDV6NUw=;
 b=rkoCGCSf6YfUPtxkdyqTAhqC4HStg4el23bY5N7WaXmXLzHKA3qP59/cxXacaGW000
 5sas2T1qz4bsdHxxrYD6jfNCPbAFVD8vfeDLLqJcMvVg1D/xpFUIO7VqU32I+wIazPK7
 KSimydnLsBaLxyGizbwaVBeqJFJzIaj1XMV4Cy/7AvtGKesAwxCu5l88osL3RYXXPn7Z
 bnBaeE/yLpj9KuvMQwpcp0H59KsRPxu1uUZIOE6RO5bPCpdK81FDsloR+WrSPRVRxyHP
 2mOmkfZVR7GVbuIH7oEvLnJJ0Y467X55+ijK3LIqEvIqKa6WxwwcVBQN5jpPxh+o0uO0
 Y4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iWoWhHbCCpEvLIEcPxGwRrtxC+U9ERYPozD4RDV6NUw=;
 b=DqN/hWmje0679hs0u7aXHn7m4SuQUmc28CCFzEUokwMfBe5Ot0TR+9aA8w3q1tN2lM
 RLFHmszGMgMV5nLol4a1P70y5Xxvy7tGMEax2R450t29Ez93lSuJzuBqscBy0SdVWcx6
 slY0603IRS0vM6zhBfnGHeksK2FwcVwWMksxWUpRJGvTMXle94jy9fGP9XWnLQlFg22P
 XQFYvyiJ/Ypchb9rzs5WhHDt71JxxPHGJsvEj6OxGqT+/G+zMLrDfS9gQVhSESsZf8n5
 9wA/o0P+TOKrxXYV7bdcyO7DVPvGQz2zznLqNy5xQIbuLtUwMp31Aw3cqsFdaybz38a5
 IKdg==
X-Gm-Message-State: AHQUAuaMYjj60HdjWO5514M5UOmVvJrE6Q560bscuYQQl10lsUU1tM2y
 Rj588TTkbCM0SOG2SYjGJ7iiPw==
X-Google-Smtp-Source: AHgI3IZqy5gYCKiIzjE6qlrAcoEmVmkbm6YQx8rxybBIKs/pPhzukhSzoYCSpOreZr0hSrOc2lfCFQ==
X-Received: by 2002:a1c:9dc4:: with SMTP id g187mr2389151wme.152.1549025934895; 
 Fri, 01 Feb 2019 04:58:54 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id w16sm8709750wrp.1.2019.02.01.04.58.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 04:58:54 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v2 4/4] clk: meson: rework and clean drivers dependencies
Date: Fri,  1 Feb 2019 13:58:41 +0100
Message-Id: <20190201125841.26785-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201125841.26785-1-jbrunet@baylibre.com>
References: <20190201125841.26785-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_045857_965888_D81230C0 
X-CRM114-Status: GOOD (  21.79  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Initially, the meson clock directory only hosted 2 controllers drivers,
for meson8 and gxbb. At the time, both used the same set of clock drivers
so managing the dependencies was not a big concern.

Since this ancient time, entropy did its job, controllers with different
requirement and specific clock drivers have been added. Unfortunately, we
did not do a great job at managing the dependencies between the
controllers and the different clock drivers. Some drivers, such as
clk-phase or vid-pll-div, are compiled even if they are useless on the
target (meson8). As we are adding new controllers, we need to be able to
pick a driver w/o pulling the whole thing.

The patch aims to clean things up by:
* providing a dedicated CONFIG_ for each clock drivers
* allowing clock drivers to be compiled as a modules, if possible
* stating explicitly which drivers are required by each controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig                     |  82 +++++++---
 drivers/clk/meson/Makefile                    |  27 ++--
 drivers/clk/meson/axg-aoclk.c                 |   4 +-
 drivers/clk/meson/axg-audio.c                 |   5 +-
 drivers/clk/meson/axg.c                       |   5 +-
 drivers/clk/meson/clk-dualdiv.c               |  10 +-
 drivers/clk/meson/clk-dualdiv.h               |  33 ++++
 drivers/clk/meson/clk-input.c                 |   7 +-
 drivers/clk/meson/clk-input.h                 |  19 +++
 drivers/clk/meson/clk-mpll.c                  |  12 +-
 drivers/clk/meson/clk-mpll.h                  |  30 ++++
 drivers/clk/meson/clk-phase.c                 |  75 ++++++++-
 drivers/clk/meson/clk-phase.h                 |  26 ++++
 drivers/clk/meson/clk-pll.c                   |  13 +-
 drivers/clk/meson/clk-pll.h                   |  43 ++++++
 drivers/clk/meson/clk-regmap.c                |   5 +
 drivers/clk/meson/clk-regmap.h                |  15 ++
 drivers/clk/meson/clk-triphase.c              |  68 --------
 drivers/clk/meson/clkc.h                      | 146 ------------------
 drivers/clk/meson/gxbb-aoclk.c                |   4 +-
 drivers/clk/meson/gxbb.c                      |   5 +-
 drivers/clk/meson/meson-aoclk.c               |   2 +
 drivers/clk/meson/meson-aoclk.h               |   5 +-
 drivers/clk/meson/meson8b.c                   |   3 +-
 drivers/clk/meson/parm.h                      |  46 ++++++
 drivers/clk/meson/sclk-div.c                  |  10 +-
 .../clk/meson/{clkc-audio.h => sclk-div.h}    |  16 +-
 drivers/clk/meson/vid-pll-div.c               |  10 +-
 drivers/clk/meson/vid-pll-div.h               |  20 +++
 29 files changed, 465 insertions(+), 281 deletions(-)
 create mode 100644 drivers/clk/meson/clk-dualdiv.h
 create mode 100644 drivers/clk/meson/clk-input.h
 create mode 100644 drivers/clk/meson/clk-mpll.h
 create mode 100644 drivers/clk/meson/clk-phase.h
 create mode 100644 drivers/clk/meson/clk-pll.h
 delete mode 100644 drivers/clk/meson/clk-triphase.c
 delete mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/parm.h
 rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (54%)
 create mode 100644 drivers/clk/meson/vid-pll-div.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 2479dab09d70..f2e757aea4f1 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,27 +1,47 @@
-config COMMON_CLK_AMLOGIC
-	bool
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_REGMAP_MESON
+config COMMON_CLK_MESON_INPUT
+	tristate
 
-config COMMON_CLK_AMLOGIC_AUDIO
-	bool
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_AMLOGIC
+config COMMON_CLK_MESON_REGMAP
+	tristate
+	select REGMAP
 
-config COMMON_CLK_MESON_AO
-	bool
-	depends on OF
-	depends on ARCH_MESON || COMPILE_TEST
-	select COMMON_CLK_REGMAP_MESON
-	select RESET_CONTROLLER
+config COMMON_CLK_MESON_DUALDIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
 
-config COMMON_CLK_REGMAP_MESON
-	bool
-	select REGMAP
+config COMMON_CLK_MESON_MPLL
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_PHASE
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_PLL
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_SCLK_DIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_VID_PLL_DIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
+config COMMON_CLK_MESON_AO_CLKC
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_INPUT
+	select RESET_CONTROLLER
 
 config COMMON_CLK_MESON8B
 	bool
-	select COMMON_CLK_AMLOGIC
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select MFD_SYSCON
 	select RESET_CONTROLLER
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
@@ -30,8 +50,14 @@ config COMMON_CLK_MESON8B
 
 config COMMON_CLK_GXBB
 	bool
-	select COMMON_CLK_AMLOGIC
-	select COMMON_CLK_MESON_AO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_VID_PLL_DIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
@@ -39,8 +65,13 @@ config COMMON_CLK_GXBB
 
 config COMMON_CLK_AXG
 	bool
-	select COMMON_CLK_AMLOGIC
-	select COMMON_CLK_MESON_AO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_AO_CLKC
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
@@ -48,8 +79,11 @@ config COMMON_CLK_AXG
 
 config COMMON_CLK_AXG_AUDIO
 	tristate "Meson AXG Audio Clock Controller Driver"
-	depends on COMMON_CLK_AXG
-	select COMMON_CLK_AMLOGIC_AUDIO
+	depends on ARCH_MESON
+	select COMMON_CLK_MESON_INPUT
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_PHASE
+	select COMMON_CLK_MESON_SCLK_DIV
 	select REGMAP_MMIO
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 8234e92eea38..e339d8f58488 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -1,13 +1,18 @@
-#
-# Makefile for Meson specific clk
-#
+# Amlogic clock drivers
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
-obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
+obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
+obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
+obj-$(CONFIG_COMMON_CLK_MESON_INPUT) += clk-input.o
+obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
+obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
+obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
+obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
+obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
+
+# Amlogic Clock controllers
+
+obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
+obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
+obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
-obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
-obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
-obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index 5701f5840b75..0086f31288eb 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -12,10 +12,12 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/mfd/syscon.h>
-#include "clkc.h"
 #include "meson-aoclk.h"
 #include "axg-aoclk.h"
 
+#include "clk-regmap.h"
+#include "clk-dualdiv.h"
+
 #define IN_PREFIX "ao-in-"
 
 /*
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8ac3a2295473..7ab200b6c3bf 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -14,8 +14,11 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include "clkc-audio.h"
 #include "axg-audio.h"
+#include "clk-input.h"
+#include "clk-regmap.h"
+#include "clk-phase.h"
+#include "sclk-div.h"
 
 #define AXG_MST_IN_COUNT	8
 #define AXG_SLV_SCLK_COUNT	10
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 1c6539eeee7c..cbbdd93b175d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -17,7 +17,10 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include "clkc.h"
+#include "clk-input.h"
+#include "clk-regmap.h"
+#include "clk-pll.h"
+#include "clk-mpll.h"
 #include "axg.h"
 
 #define IN_PREFIX "ee-in-"
diff --git a/drivers/clk/meson/clk-dualdiv.c b/drivers/clk/meson/clk-dualdiv.c
index 4d9e161de627..c5ca23a5e3e8 100644
--- a/drivers/clk/meson/clk-dualdiv.c
+++ b/drivers/clk/meson/clk-dualdiv.c
@@ -22,7 +22,10 @@
  */
 
 #include <linux/clk-provider.h>
-#include "clkc.h"
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "clk-dualdiv.h"
 
 static inline struct meson_clk_dualdiv_data *
 meson_clk_dualdiv_data(struct clk_regmap *clk)
@@ -128,3 +131,8 @@ const struct clk_ops meson_clk_dualdiv_ro_ops = {
 	.recalc_rate	= meson_clk_dualdiv_recalc_rate,
 };
 EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic dual divider driver");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-dualdiv.h b/drivers/clk/meson/clk-dualdiv.h
new file mode 100644
index 000000000000..4aa939018012
--- /dev/null
+++ b/drivers/clk/meson/clk-dualdiv.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_DUALDIV_H
+#define __MESON_CLK_DUALDIV_H
+
+#include <linux/clk-provider.h>
+#include "parm.h"
+
+struct meson_clk_dualdiv_param {
+	unsigned int n1;
+	unsigned int n2;
+	unsigned int m1;
+	unsigned int m2;
+	unsigned int dual;
+};
+
+struct meson_clk_dualdiv_data {
+	struct parm n1;
+	struct parm n2;
+	struct parm m1;
+	struct parm m2;
+	struct parm dual;
+	const struct meson_clk_dualdiv_param *table;
+};
+
+extern const struct clk_ops meson_clk_dualdiv_ops;
+extern const struct clk_ops meson_clk_dualdiv_ro_ops;
+
+#endif /* __MESON_CLK_DUALDIV_H */
diff --git a/drivers/clk/meson/clk-input.c b/drivers/clk/meson/clk-input.c
index 06b3e3bb6a66..086226e9dba6 100644
--- a/drivers/clk/meson/clk-input.c
+++ b/drivers/clk/meson/clk-input.c
@@ -7,7 +7,8 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
-#include "clkc.h"
+#include <linux/module.h>
+#include "clk-input.h"
 
 static const struct clk_ops meson_clk_no_ops = {};
 
@@ -42,3 +43,7 @@ struct clk_hw *meson_clk_hw_register_input(struct device *dev,
 	return ret ? ERR_PTR(ret) : hw;
 }
 EXPORT_SYMBOL_GPL(meson_clk_hw_register_input);
+
+MODULE_DESCRIPTION("Amlogic clock input helper");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-input.h b/drivers/clk/meson/clk-input.h
new file mode 100644
index 000000000000..4a541b9685a6
--- /dev/null
+++ b/drivers/clk/meson/clk-input.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_INPUT_H
+#define __MESON_CLK_INPUT_H
+
+#include <linux/clk-provider.h>
+
+struct device;
+
+struct clk_hw *meson_clk_hw_register_input(struct device *dev,
+					   const char *of_name,
+					   const char *clk_name,
+					   unsigned long flags);
+
+#endif /* __MESON_CLK_INPUT_H */
diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 650f75cc15a9..f76850d99e59 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -12,7 +12,11 @@
  */
 
 #include <linux/clk-provider.h>
-#include "clkc.h"
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include "clk-regmap.h"
+#include "clk-mpll.h"
 
 #define SDM_DEN 16384
 #define N2_MIN	4
@@ -138,9 +142,15 @@ const struct clk_ops meson_clk_mpll_ro_ops = {
 	.recalc_rate	= mpll_recalc_rate,
 	.round_rate	= mpll_round_rate,
 };
+EXPORT_SYMBOL_GPL(meson_clk_mpll_ro_ops);
 
 const struct clk_ops meson_clk_mpll_ops = {
 	.recalc_rate	= mpll_recalc_rate,
 	.round_rate	= mpll_round_rate,
 	.set_rate	= mpll_set_rate,
 };
+EXPORT_SYMBOL_GPL(meson_clk_mpll_ops);
+
+MODULE_DESCRIPTION("Amlogic MPLL driver");
+MODULE_AUTHOR("Michael Turquette <mturquette@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-mpll.h b/drivers/clk/meson/clk-mpll.h
new file mode 100644
index 000000000000..cf79340006dd
--- /dev/null
+++ b/drivers/clk/meson/clk-mpll.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_MPLL_H
+#define __MESON_CLK_MPLL_H
+
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+
+#include "parm.h"
+
+struct meson_clk_mpll_data {
+	struct parm sdm;
+	struct parm sdm_en;
+	struct parm n2;
+	struct parm ssen;
+	struct parm misc;
+	spinlock_t *lock;
+	u8 flags;
+};
+
+#define CLK_MESON_MPLL_ROUND_CLOSEST	BIT(0)
+
+extern const struct clk_ops meson_clk_mpll_ro_ops;
+extern const struct clk_ops meson_clk_mpll_ops;
+
+#endif /* __MESON_CLK_MPLL_H */
diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
index cba43748ce3d..80c3ada193a4 100644
--- a/drivers/clk/meson/clk-phase.c
+++ b/drivers/clk/meson/clk-phase.c
@@ -5,7 +5,10 @@
  */
 
 #include <linux/clk-provider.h>
-#include "clkc.h"
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "clk-phase.h"
 
 #define phase_step(_width) (360 / (1 << (_width)))
 
@@ -15,13 +18,12 @@ meson_clk_phase_data(struct clk_regmap *clk)
 	return (struct meson_clk_phase_data *)clk->data;
 }
 
-int meson_clk_degrees_from_val(unsigned int val, unsigned int width)
+static int meson_clk_degrees_from_val(unsigned int val, unsigned int width)
 {
 	return phase_step(width) * val;
 }
-EXPORT_SYMBOL_GPL(meson_clk_degrees_from_val);
 
-unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
+static unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
 {
 	unsigned int val = DIV_ROUND_CLOSEST(degrees, phase_step(width));
 
@@ -31,7 +33,6 @@ unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
 	 */
 	return val % (1 << width);
 }
-EXPORT_SYMBOL_GPL(meson_clk_degrees_to_val);
 
 static int meson_clk_phase_get_phase(struct clk_hw *hw)
 {
@@ -61,3 +62,67 @@ const struct clk_ops meson_clk_phase_ops = {
 	.set_phase	= meson_clk_phase_set_phase,
 };
 EXPORT_SYMBOL_GPL(meson_clk_phase_ops);
+
+/*
+ * This is a special clock for the audio controller.
+ * The phase of mst_sclk clock output can be controlled independently
+ * for the outside world (ph0), the tdmout (ph1) and tdmin (ph2).
+ * Controlling these 3 phases as just one makes things simpler and
+ * give the same clock view to all the element on the i2s bus.
+ * If necessary, we can still control the phase in the tdm block
+ * which makes these independent control redundant.
+ */
+static inline struct meson_clk_triphase_data *
+meson_clk_triphase_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_triphase_data *)clk->data;
+}
+
+static void meson_clk_triphase_sync(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	/* Get phase 0 and sync it to phase 1 and 2 */
+	val = meson_parm_read(clk->map, &tph->ph0);
+	meson_parm_write(clk->map, &tph->ph1, val);
+	meson_parm_write(clk->map, &tph->ph2, val);
+}
+
+static int meson_clk_triphase_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	/* Phase are in sync, reading phase 0 is enough */
+	val = meson_parm_read(clk->map, &tph->ph0);
+
+	return meson_clk_degrees_from_val(val, tph->ph0.width);
+}
+
+static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
+	meson_parm_write(clk->map, &tph->ph0, val);
+	meson_parm_write(clk->map, &tph->ph1, val);
+	meson_parm_write(clk->map, &tph->ph2, val);
+
+	return 0;
+}
+
+const struct clk_ops meson_clk_triphase_ops = {
+	.init		= meson_clk_triphase_sync,
+	.get_phase	= meson_clk_triphase_get_phase,
+	.set_phase	= meson_clk_triphase_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
+
+MODULE_DESCRIPTION("Amlogic phase driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-phase.h b/drivers/clk/meson/clk-phase.h
new file mode 100644
index 000000000000..5579f9ced142
--- /dev/null
+++ b/drivers/clk/meson/clk-phase.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_PHASE_H
+#define __MESON_CLK_PHASE_H
+
+#include <linux/clk-provider.h>
+#include "parm.h"
+
+struct meson_clk_phase_data {
+	struct parm ph;
+};
+
+struct meson_clk_triphase_data {
+	struct parm ph0;
+	struct parm ph1;
+	struct parm ph2;
+};
+
+extern const struct clk_ops meson_clk_phase_ops;
+extern const struct clk_ops meson_clk_triphase_ops;
+
+#endif /* __MESON_CLK_PHASE_H */
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index afffc1547e20..4a8c68ae8801 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -32,11 +32,9 @@
 #include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 
-#include "clkc.h"
+#include "clk-regmap.h"
+#include "clk-pll.h"
 
 static inline struct meson_clk_pll_data *
 meson_clk_pll_data(struct clk_regmap *clk)
@@ -309,8 +307,15 @@ const struct clk_ops meson_clk_pll_ops = {
 	.enable		= meson_clk_pll_enable,
 	.disable	= meson_clk_pll_disable
 };
+EXPORT_SYMBOL_GPL(meson_clk_pll_ops);
 
 const struct clk_ops meson_clk_pll_ro_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.is_enabled	= meson_clk_pll_is_enabled,
 };
+EXPORT_SYMBOL_GPL(meson_clk_pll_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic PLL driver");
+MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
new file mode 100644
index 000000000000..5ccf0854d932
--- /dev/null
+++ b/drivers/clk/meson/clk-pll.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_PLL_H
+#define __MESON_CLK_PLL_H
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include "parm.h"
+
+struct pll_params_table {
+	u16		m;
+	u16		n;
+};
+
+#define PLL_PARAMS(_m, _n)						\
+	{								\
+		.m		= (_m),					\
+		.n		= (_n),					\
+	}
+
+#define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
+
+struct meson_clk_pll_data {
+	struct parm en;
+	struct parm m;
+	struct parm n;
+	struct parm frac;
+	struct parm l;
+	struct parm rst;
+	const struct reg_sequence *init_regs;
+	unsigned int init_count;
+	const struct pll_params_table *table;
+	u8 flags;
+};
+
+extern const struct clk_ops meson_clk_pll_ro_ops;
+extern const struct clk_ops meson_clk_pll_ops;
+
+#endif /* __MESON_CLK_PLL_H */
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index c515f67322a3..dcd1757cc5df 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -4,6 +4,7 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
 
+#include <linux/module.h>
 #include "clk-regmap.h"
 
 static int clk_regmap_gate_endisable(struct clk_hw *hw, int enable)
@@ -180,3 +181,7 @@ const struct clk_ops clk_regmap_mux_ro_ops = {
 	.get_parent = clk_regmap_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic regmap backed clock driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index e9c5728d40eb..b7a085bbf072 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -111,4 +111,19 @@ clk_get_regmap_mux_data(struct clk_regmap *clk)
 extern const struct clk_ops clk_regmap_mux_ops;
 extern const struct clk_ops clk_regmap_mux_ro_ops;
 
+#define MESON_GATE(_name, _reg, _bit)					\
+struct clk_regmap _name = {						\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ "clk81" },		\
+		.num_parents = 1,					\
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+	},								\
+}
+
 #endif /* __CLK_REGMAP_H */
diff --git a/drivers/clk/meson/clk-triphase.c b/drivers/clk/meson/clk-triphase.c
deleted file mode 100644
index 4a59936251e5..000000000000
--- a/drivers/clk/meson/clk-triphase.c
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (c) 2018 BayLibre, SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#include <linux/clk-provider.h>
-#include "clkc-audio.h"
-
-/*
- * This is a special clock for the audio controller.
- * The phase of mst_sclk clock output can be controlled independently
- * for the outside world (ph0), the tdmout (ph1) and tdmin (ph2).
- * Controlling these 3 phases as just one makes things simpler and
- * give the same clock view to all the element on the i2s bus.
- * If necessary, we can still control the phase in the tdm block
- * which makes these independent control redundant.
- */
-static inline struct meson_clk_triphase_data *
-meson_clk_triphase_data(struct clk_regmap *clk)
-{
-	return (struct meson_clk_triphase_data *)clk->data;
-}
-
-static void meson_clk_triphase_sync(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
-	unsigned int val;
-
-	/* Get phase 0 and sync it to phase 1 and 2 */
-	val = meson_parm_read(clk->map, &tph->ph0);
-	meson_parm_write(clk->map, &tph->ph1, val);
-	meson_parm_write(clk->map, &tph->ph2, val);
-}
-
-static int meson_clk_triphase_get_phase(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
-	unsigned int val;
-
-	/* Phase are in sync, reading phase 0 is enough */
-	val = meson_parm_read(clk->map, &tph->ph0);
-
-	return meson_clk_degrees_from_val(val, tph->ph0.width);
-}
-
-static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
-	unsigned int val;
-
-	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
-	meson_parm_write(clk->map, &tph->ph0, val);
-	meson_parm_write(clk->map, &tph->ph1, val);
-	meson_parm_write(clk->map, &tph->ph2, val);
-
-	return 0;
-}
-
-const struct clk_ops meson_clk_triphase_ops = {
-	.init		= meson_clk_triphase_sync,
-	.get_phase	= meson_clk_triphase_get_phase,
-	.set_phase	= meson_clk_triphase_set_phase,
-};
-EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
deleted file mode 100644
index e3cd442db739..000000000000
--- a/drivers/clk/meson/clkc.h
+++ /dev/null
@@ -1,146 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2015 Endless Mobile, Inc.
- * Author: Carlo Caione <carlo@endlessm.com>
- */
-
-#ifndef __CLKC_H
-#define __CLKC_H
-
-#include <linux/clk-provider.h>
-#include "clk-regmap.h"
-
-#define PMASK(width)			GENMASK(width - 1, 0)
-#define SETPMASK(width, shift)		GENMASK(shift + width - 1, shift)
-#define CLRPMASK(width, shift)		(~SETPMASK(width, shift))
-
-#define PARM_GET(width, shift, reg)					\
-	(((reg) & SETPMASK(width, shift)) >> (shift))
-#define PARM_SET(width, shift, reg, val)				\
-	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
-
-#define MESON_PARM_APPLICABLE(p)		(!!((p)->width))
-
-struct parm {
-	u16	reg_off;
-	u8	shift;
-	u8	width;
-};
-
-static inline unsigned int meson_parm_read(struct regmap *map, struct parm *p)
-{
-	unsigned int val;
-
-	regmap_read(map, p->reg_off, &val);
-	return PARM_GET(p->width, p->shift, val);
-}
-
-static inline void meson_parm_write(struct regmap *map, struct parm *p,
-				    unsigned int val)
-{
-	regmap_update_bits(map, p->reg_off, SETPMASK(p->width, p->shift),
-			   val << p->shift);
-}
-
-
-struct pll_params_table {
-	u16		m;
-	u16		n;
-};
-
-#define PLL_PARAMS(_m, _n)						\
-	{								\
-		.m		= (_m),					\
-		.n		= (_n),					\
-	}
-
-#define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
-
-struct meson_clk_pll_data {
-	struct parm en;
-	struct parm m;
-	struct parm n;
-	struct parm frac;
-	struct parm l;
-	struct parm rst;
-	const struct reg_sequence *init_regs;
-	unsigned int init_count;
-	const struct pll_params_table *table;
-	u8 flags;
-};
-
-#define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
-
-struct meson_clk_mpll_data {
-	struct parm sdm;
-	struct parm sdm_en;
-	struct parm n2;
-	struct parm ssen;
-	struct parm misc;
-	spinlock_t *lock;
-	u8 flags;
-};
-
-#define CLK_MESON_MPLL_ROUND_CLOSEST	BIT(0)
-
-struct meson_clk_phase_data {
-	struct parm ph;
-};
-
-int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
-unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
-
-struct meson_vid_pll_div_data {
-	struct parm val;
-	struct parm sel;
-};
-
-#define MESON_GATE(_name, _reg, _bit)					\
-struct clk_regmap _name = {						\
-	.data = &(struct clk_regmap_gate_data){				\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = #_name,						\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ "clk81" },		\
-		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
-	},								\
-};
-
-struct meson_clk_dualdiv_param {
-	unsigned int n1;
-	unsigned int n2;
-	unsigned int m1;
-	unsigned int m2;
-	unsigned int dual;
-};
-
-struct meson_clk_dualdiv_data {
-	struct parm n1;
-	struct parm n2;
-	struct parm m1;
-	struct parm m2;
-	struct parm dual;
-	const struct meson_clk_dualdiv_param *table;
-};
-
-/* clk_ops */
-extern const struct clk_ops meson_clk_pll_ro_ops;
-extern const struct clk_ops meson_clk_pll_ops;
-extern const struct clk_ops meson_clk_cpu_ops;
-extern const struct clk_ops meson_clk_mpll_ro_ops;
-extern const struct clk_ops meson_clk_mpll_ops;
-extern const struct clk_ops meson_clk_phase_ops;
-extern const struct clk_ops meson_vid_pll_div_ro_ops;
-extern const struct clk_ops meson_clk_dualdiv_ops;
-extern const struct clk_ops meson_clk_dualdiv_ro_ops;
-
-struct clk_hw *meson_clk_hw_register_input(struct device *dev,
-					   const char *of_name,
-					   const char *clk_name,
-					   unsigned long flags);
-
-#endif /* __CLKC_H */
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 510b6a7d2f18..449f6ac189d8 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -5,10 +5,12 @@
  */
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
-#include "clkc.h"
 #include "meson-aoclk.h"
 #include "gxbb-aoclk.h"
 
+#include "clk-regmap.h"
+#include "clk-dualdiv.h"
+
 #define IN_PREFIX "ao-in-"
 
 /* AO Configuration Clock registers offsets */
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ecf9a8f6281c..3741db9a9fe1 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -12,9 +12,12 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include "clkc.h"
 #include "gxbb.h"
+#include "clk-input.h"
 #include "clk-regmap.h"
+#include "clk-pll.h"
+#include "clk-mpll.h"
+#include "vid-pll-div.h"
 
 #define IN_PREFIX "ee-in-"
 
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 7b9d194ccc3b..b67951909e04 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include "meson-aoclk.h"
 
+#include "clk-input.h"
+
 static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index 0758b35d4427..999cde3868f7 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -11,9 +11,12 @@
 #ifndef __MESON_AOCLK_H__
 #define __MESON_AOCLK_H__
 
+#include <linux/clk-provider.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
-#include "clkc.h"
+
+#include "clk-regmap.h"
 
 struct meson_aoclk_input {
 	const char *name;
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 748552c5f6c8..23b1e355a849 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -16,9 +16,10 @@
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
-#include "clkc.h"
 #include "meson8b.h"
 #include "clk-regmap.h"
+#include "clk-pll.h"
+#include "clk-mpll.h"
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
diff --git a/drivers/clk/meson/parm.h b/drivers/clk/meson/parm.h
new file mode 100644
index 000000000000..3c9ef1b505ce
--- /dev/null
+++ b/drivers/clk/meson/parm.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ */
+
+#ifndef __MESON_PARM_H
+#define __MESON_PARM_H
+
+#include <linux/bits.h>
+#include <linux/regmap.h>
+
+#define PMASK(width)			GENMASK(width - 1, 0)
+#define SETPMASK(width, shift)		GENMASK(shift + width - 1, shift)
+#define CLRPMASK(width, shift)		(~SETPMASK(width, shift))
+
+#define PARM_GET(width, shift, reg)					\
+	(((reg) & SETPMASK(width, shift)) >> (shift))
+#define PARM_SET(width, shift, reg, val)				\
+	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
+
+#define MESON_PARM_APPLICABLE(p)		(!!((p)->width))
+
+struct parm {
+	u16	reg_off;
+	u8	shift;
+	u8	width;
+};
+
+static inline unsigned int meson_parm_read(struct regmap *map, struct parm *p)
+{
+	unsigned int val;
+
+	regmap_read(map, p->reg_off, &val);
+	return PARM_GET(p->width, p->shift, val);
+}
+
+static inline void meson_parm_write(struct regmap *map, struct parm *p,
+				    unsigned int val)
+{
+	regmap_update_bits(map, p->reg_off, SETPMASK(p->width, p->shift),
+			   val << p->shift);
+}
+
+#endif /* __MESON_PARM_H */
+
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index bc64019b8eeb..3acf03780221 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -16,7 +16,11 @@
  * duty_cycle = (1 + hi) / (1 + val)
  */
 
-#include "clkc-audio.h"
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "sclk-div.h"
 
 static inline struct meson_sclk_div_data *
 meson_sclk_div_data(struct clk_regmap *clk)
@@ -241,3 +245,7 @@ const struct clk_ops meson_sclk_div_ops = {
 	.init		= sclk_div_init,
 };
 EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
+
+MODULE_DESCRIPTION("Amlogic Sample divider driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/sclk-div.h
similarity index 54%
rename from drivers/clk/meson/clkc-audio.h
rename to drivers/clk/meson/sclk-div.h
index 0a7c157ebf81..b64b2a32005f 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/sclk-div.h
@@ -4,16 +4,11 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
 
-#ifndef __MESON_CLKC_AUDIO_H
-#define __MESON_CLKC_AUDIO_H
+#ifndef __MESON_SCLK_DIV_H
+#define __MESON_SCLK_DIV_H
 
-#include "clkc.h"
-
-struct meson_clk_triphase_data {
-	struct parm ph0;
-	struct parm ph1;
-	struct parm ph2;
-};
+#include <linux/clk-provider.h>
+#include "parm.h"
 
 struct meson_sclk_div_data {
 	struct parm div;
@@ -22,7 +17,6 @@ struct meson_sclk_div_data {
 	struct clk_duty cached_duty;
 };
 
-extern const struct clk_ops meson_clk_triphase_ops;
 extern const struct clk_ops meson_sclk_div_ops;
 
-#endif /* __MESON_CLKC_AUDIO_H */
+#endif /* __MESON_SCLK_DIV_H */
diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index 88af0e282ea0..08bcc01c0923 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -5,7 +5,10 @@
  */
 
 #include <linux/clk-provider.h>
-#include "clkc.h"
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "vid-pll-div.h"
 
 static inline struct meson_vid_pll_div_data *
 meson_vid_pll_div_data(struct clk_regmap *clk)
@@ -89,3 +92,8 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
 const struct clk_ops meson_vid_pll_div_ro_ops = {
 	.recalc_rate	= meson_vid_pll_div_recalc_rate,
 };
+EXPORT_SYMBOL_GPL(meson_vid_pll_div_ro_ops);
+
+MODULE_DESCRIPTION("Amlogic video pll divider driver");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
new file mode 100644
index 000000000000..c0128e33ccf9
--- /dev/null
+++ b/drivers/clk/meson/vid-pll-div.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_VID_PLL_DIV_H
+#define __MESON_VID_PLL_DIV_H
+
+#include <linux/clk-provider.h>
+#include "parm.h"
+
+struct meson_vid_pll_div_data {
+	struct parm val;
+	struct parm sel;
+};
+
+extern const struct clk_ops meson_vid_pll_div_ro_ops;
+
+#endif /* __MESON_VID_PLL_DIV_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
