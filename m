Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8268EC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459D52148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kZT5JrRk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bLJpQmG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459D52148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ojb3ROVTNpP2fzpAvgpU0EiQgdluMiUU2zc1zolB7os=; b=kZT5JrRkxM05j3
	HHm1lwP7y1UcaNDwhlLGFmd6PGWrVcwlKrrv957TUjUXDGhJ3ZH9Bdps7U+EMi/dRf4HpHjklSEWh
	UvUFmqVdH4BzcUCf7iZAEdxy2tnXBWZZOz6kXDarc/GFMDMRGvNdI5Txc7jdAV3CPsDk5h91HYVRb
	TArzzJdT//XK2om+MxgpoEr7+4cu5Hoi9pXxd6M2AVMqet+uVSA2vmx2XiTklfGalSAV0GbWRQHi5
	MZ/lK1WW5TwRNvXAu/lh8RlVAbjs+7g1ntyblpdCsi6qWa6ZWYc9036qgj4REBdFM3HhXqDh+76Qa
	f5UBs8ee50VuU5cMOZAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBKR-0007YX-9i; Mon, 28 Jan 2019 18:08:15 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBHC-0003mb-MC
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:05:12 +0000
Received: by mail-wr1-x443.google.com with SMTP id f7so19209471wrp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nbXfyjfqzqGpHsSm+wGVBTSI4vzKOQ2CLwSheFxJ0pY=;
 b=bLJpQmG4xEa3nqZqf2uYPgGgvShCScNAnZJS/q4tIDJxY5DwMpFJZ6mdtcbmCk/HP1
 3O/hdz5zfiulKkSzwA5TFEOFbS7E+gG4O4V0aVFaxQg/TUWTmnOlX+Gk8CHQN4dvuaRr
 SUbrk8P8HqMB2t2froBrbHPnoLt1VOso5vywumJuWHFv5OSv6pGEekrC2TMP0zm1O6P/
 WPJTLq4oZmGIVhUNkKJt7UpP3pANfvFrUzdYdUc9qMG+gqsEvzdeQmmyqzLIZbgtkihu
 4OZ7gqRALpFPdLOzxOIDtLt0efq3sYAqMUIjBg0lMHrIzz0iuXII0gHXWKJU+YuGPbBS
 7jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nbXfyjfqzqGpHsSm+wGVBTSI4vzKOQ2CLwSheFxJ0pY=;
 b=kK3ZGhCigFPQUTpVDR5jOttniKxg3v7jUWKQ9RLbROfABZNgXylHOFo7bxJ6ekGkKG
 yYzSf98w+gevMtBlEtEAsN8s0Zpc/GeXzgQAUHfB4TqXRy6+mD7zWTj01ycpGKBMzLkS
 KyOsDexgIj42N0U9vD4NikQpdT9Qjdw2rF90WuFIWzVYp+RMxBq+FlBgxp87HrK92BX2
 y5ATsKLnZrh0zhvlwOMrMnSxDItqqj2VFX6+k34GGB/sbYy4op2uj8+0db/3tt5OTOep
 OQxkMpRaV2qcDD+Lw5uuRnRWrZqY9r9qwLrcicJqWT2zA78MkOEgUXyK8ClG1KWSLAkC
 aS8w==
X-Gm-Message-State: AHQUAuZ++nEZ7jfWrtqrEZd4WwwK0Mi65QEvxnVU8ayW9cSzv4kNS6qm
 3Z9EFOtVbd+2lflswa71J1nhyq4GJmk=
X-Google-Smtp-Source: AHgI3Ibf86P6JrR4OEXFj0tAJZiXCpcxEJRKZPGFbtTm60QemWO8lWx4yqtwQENi/Hxu6K3Voru+hg==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr15171607wrr.105.1548698693294; 
 Mon, 28 Jan 2019 10:04:53 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:52 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 07/14] clk: meson: take the mpll driver out of clkc
Date: Mon, 28 Jan 2019 19:04:23 +0100
Message-Id: <20190128180430.28689-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100455_252789_280F095F 
X-CRM114-Status: GOOD (  16.02  )
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

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c      |  1 +
 drivers/clk/meson/clk-mpll.c | 12 +++++++++++-
 drivers/clk/meson/clk-mpll.h | 30 ++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h     | 14 --------------
 drivers/clk/meson/gxbb.c     |  1 +
 drivers/clk/meson/meson8b.c  |  1 +
 6 files changed, 44 insertions(+), 15 deletions(-)
 create mode 100644 drivers/clk/meson/clk-mpll.h

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 8a3896fa343f..dc973b4324f3 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -20,6 +20,7 @@
 #include "clkc.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
+#include "clk-mpll.h"
 #include "axg.h"
 
 #define IN_PREFIX "ee-in-"
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
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 4857c8fa1ac4..32947bd76bab 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -11,18 +11,6 @@
 #include "clk-regmap.h"
 #include "parm.h"
 
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
 struct meson_clk_phase_data {
 	struct parm ph;
 };
@@ -54,8 +42,6 @@ struct meson_clk_dualdiv_data {
 
 /* clk_ops */
 extern const struct clk_ops meson_clk_cpu_ops;
-extern const struct clk_ops meson_clk_mpll_ro_ops;
-extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
 extern const struct clk_ops meson_clk_dualdiv_ops;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 813822ec5f57..6a8358f3e0ef 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -16,6 +16,7 @@
 #include "gxbb.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
+#include "clk-mpll.h"
 
 #define IN_PREFIX "ee-in-"
 
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9b35d5e08378..91a5306b13f6 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -20,6 +20,7 @@
 #include "meson8b.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
+#include "clk-mpll.h"
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
