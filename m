Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3414FC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026982148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GgL2EBDv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VQQPTmVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026982148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qIjj1yGJTbUnZ5cE0CXdAaN7NyWEZ456ijjn6ngRY9Y=; b=GgL2EBDvGJrVYS
	mL3qq/3+o6bDZqZJBAU6s6HJ3XkFkxZfUViLoswDZkgrDmgzF/2zaaxrBPjf99MW/1WAihGPnoQiL
	Ul/H7rmjTFSp2ZFF1w/j2xRixRan2YjxUObXy0tA7vtoI443Rg5hD9P11jblT8+E8oPZaFthMNjRS
	35lUbtGlb9hYBTBwxos8Orcy7FsyRlEL4qdHxtEDBXgIFEcv+mW0Kn2NVF7MWf6M/J1Mf9TBrFwUz
	f1BSi+e2MPn9TMF3Qj1zI/zO6qRfDeiBb9QLVlzZljCpEfUXAskWHxVpC6fcaVt8O/F9TgtBrfByQ
	zGFJVTFjBhZjSN8ANsLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBLD-0008Ot-Rj; Mon, 28 Jan 2019 18:09:03 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBHE-0003ol-Sd
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:05:18 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so19126818wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JUR8W8hKsfFkxJFYM1wEeTrBndL0qQzv53iIlKiqwe0=;
 b=VQQPTmVe5xTKWPiEPhHSpasmWoYJyMDUs+89vqVX4AjmltGYVkZJTL8gTSPkWAPZhS
 SJlOjoSk9PFeYXgJEJNd4+QnzUUaVOE/U9gy4okz2styboVxC7L+TZtbD2k/KeRab+ti
 dRHq9LLTXjdFYyfcLZVpPufVGNRELuh4F61pafspgoxUv9lUYQvCJSDrEvEUOhPhCEWS
 713fCqs6RF54TKqvkQrjC8pUS/6K26hnvEkFa6wdBubMNIbFagGJiEAUXpWHXOyemY37
 U9vIfwSGNwUwrnrBOruUFKIKgJz7bK55VpnvU2P6bAHlKY9ZHMtZqpvRvMyTs9D1acAZ
 8Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JUR8W8hKsfFkxJFYM1wEeTrBndL0qQzv53iIlKiqwe0=;
 b=FweBXcSbG07HBeWn6gUGOydOoS/VTCqiGHIbngOen5lxepSRqW3cMCWQCwH6mAMu5q
 9WqpcylODQ009iqVAtworp/0t/RmFVOY5KvmC6kxc7De64LrhKcYZ4ogY+IvCeSH5TPi
 NNWYZKk+4y6IACuaAa82psDHABrzzY5GhN+LnE04tgZfyw6c72UWacrqWMaH5enq+qSN
 5gIMQrd+wfOnJEkKA5FZVMAT/bN47s4JR9zNNLgj49YmEeXWOgumCWW82HWuOcv/bcld
 RnCwE2Oda9MoRnpY+/jdjjDMHOClF4Q1IXX1VCF1nlbyMgLQqG/TpfX6fuZG9tmlN+io
 nH1w==
X-Gm-Message-State: AJcUukfGqtLTo+Sy9u9qcNpJ9yPkr2Kv9eWOMDYG+Sz3x3tfv/JWsExD
 7BODzzQd5su1KILvFVySc41p7g==
X-Google-Smtp-Source: ALg8bN5ptqOkDczz4Gl7nJbZhxdu3hNvlXVaK9LMPMfHt9AEJr8jfqZVW2W5tsQfy1LRnLNEkSfOQw==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr21749520wrr.97.1548698695264; 
 Mon, 28 Jan 2019 10:04:55 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:54 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 08/14] clk: meson: merge phase driver and remove from clkc
Date: Mon, 28 Jan 2019 19:04:24 +0100
Message-Id: <20190128180430.28689-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100457_530245_4ED18793 
X-CRM114-Status: GOOD (  18.68  )
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
 drivers/clk/meson/Makefile       |  2 +-
 drivers/clk/meson/axg-audio.c    |  2 +
 drivers/clk/meson/clk-phase.c    | 75 +++++++++++++++++++++++++++++---
 drivers/clk/meson/clk-phase.h    | 26 +++++++++++
 drivers/clk/meson/clk-triphase.c | 68 -----------------------------
 drivers/clk/meson/clkc-audio.h   |  7 ---
 drivers/clk/meson/clkc.h         |  8 ----
 7 files changed, 99 insertions(+), 89 deletions(-)
 create mode 100644 drivers/clk/meson/clk-phase.h
 delete mode 100644 drivers/clk/meson/clk-triphase.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 8234e92eea38..2b9490dd9878 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8ac3a2295473..45d2abc3351f 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -16,6 +16,8 @@
 
 #include "clkc-audio.h"
 #include "axg-audio.h"
+#include "clk-regmap.h"
+#include "clk-phase.h"
 
 #define AXG_MST_IN_COUNT	8
 #define AXG_SLV_SCLK_COUNT	10
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
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
index 0a7c157ebf81..8e1de2a72610 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/clkc-audio.h
@@ -9,12 +9,6 @@
 
 #include "clkc.h"
 
-struct meson_clk_triphase_data {
-	struct parm ph0;
-	struct parm ph1;
-	struct parm ph2;
-};
-
 struct meson_sclk_div_data {
 	struct parm div;
 	struct parm hi;
@@ -22,7 +16,6 @@ struct meson_sclk_div_data {
 	struct clk_duty cached_duty;
 };
 
-extern const struct clk_ops meson_clk_triphase_ops;
 extern const struct clk_ops meson_sclk_div_ops;
 
 #endif /* __MESON_CLKC_AUDIO_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 32947bd76bab..e8e4067bfcd5 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -11,13 +11,6 @@
 #include "clk-regmap.h"
 #include "parm.h"
 
-struct meson_clk_phase_data {
-	struct parm ph;
-};
-
-int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
-unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
-
 struct meson_vid_pll_div_data {
 	struct parm val;
 	struct parm sel;
@@ -42,7 +35,6 @@ struct meson_clk_dualdiv_data {
 
 /* clk_ops */
 extern const struct clk_ops meson_clk_cpu_ops;
-extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
 extern const struct clk_ops meson_clk_dualdiv_ops;
 extern const struct clk_ops meson_clk_dualdiv_ro_ops;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
