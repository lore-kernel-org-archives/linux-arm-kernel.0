Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8925BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:08:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FC92148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y7qQZH9W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s9fk6aav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FC92148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iNjkv63J8w1e/BSi9OxaSDndMPtsT1LYX2b9QiJ/MOQ=; b=Y7qQZH9WHtpp0y
	n/2XCgbm2BZOY71LOxu/MrvdXAkTPvBfmbFSqmRbj1DfNwJKf6tnI1shj4iMJ3l5Ana7oWUwDGF6+
	ecoquhDCHDGietepnlaXBwHotrJIIO9DisyPjz9ra+nMcy77O9KEhZvTfBl+Vc0WX5NQRN2mpZPNe
	GLUrqsCJWhbq8UmCUvypNXdwzC6U6sJSJWs/vBAvkmKeFm+NZNoS/RaK+zWw2tbxDWSTJ+mM+EyYf
	N6PhyitDgwibDem3DVdyyYvIuXXIxC79QCUmUWVoEc9wM18JNwOqEf9E3AOLUHl0p7wCy04n5/TIN
	BCzIx9f4hJkyCLOqAEMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBKE-0007OK-VI; Mon, 28 Jan 2019 18:08:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBH9-0003j9-9T
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:05:07 +0000
Received: by mail-wr1-x441.google.com with SMTP id z5so19097802wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tFsiSEWNipF5j/nl4GiByTeXt6gTIo/QNa1h8WqspDA=;
 b=s9fk6aav/smNqwREMwe6B+H4p5UdpW7nkEjbAL+Fcun3b3/M+kxgDzUZDHB3ffeOrx
 SFY8xMWPuBg5lUGBFx2dw3beHsXwoLCQiEGgHMFCiTluBkwSDbD9qn0oSb4B05vWuvXH
 jerhvW/yMoT7ft++LPY2mGXSfES2aqAYXgxqD7zoZK3P+/ChKfDFXwdm1uEG/dE9Trgp
 3nclpK6SIjyYBqOCwJNiRPtPrbaVe1lnGN9a5YZHm9kxBkGKa0zZTUpPBCrdGTsbMxx0
 xW7MlWlrFCM7kRZxRiwfvRWNiznZSEGDAjU7hWP52YunjJPKBx3kDY51aXIjP4JGKkt9
 eAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tFsiSEWNipF5j/nl4GiByTeXt6gTIo/QNa1h8WqspDA=;
 b=LIG3MtgdqWH+NXDcwKT46NNzLjjBV/dHkJOEcSZwc/sYbWg2NKOHw35xkAOgsPlcLp
 r67BndYauuMEiWWwHOmax9+jmm+21+zOjMcPd/tv1f+UpPOo79veu0sw8Po9kBMMLqEn
 QTGGvuZ8hS0Vey3brNABGhOs3GTQECUKSVHpbd+aryp5GzxzriHlWPjfCgf086/lrOAd
 frPy4qObLpvsrVHQU5OOwOjnFLi8lm1WcX/FTyKcINLQ2aZwkLWFsZKLu960j7Sx9Uen
 xmdJbqfy8Nrd9b0qVzOLCLsTfsDfVX2mahJbOtm2ueAFefc7+oXbI7GWsxiQvPfxt8US
 AZPw==
X-Gm-Message-State: AJcUukdr3yKolYL32v/7Dn7H6drq7+RPXSHZrtMtpNt+kKsEjedJVGGK
 0384AfUjuN8cvVcNK98Y8mtbfQ==
X-Google-Smtp-Source: ALg8bN43+P7d4wrn97gV8O0Ak5AVOuyFY/9fHPH1klbLsHnSlllH1qCMuc1gy1HgllQVPkmK6SXfUA==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr22600942wrw.225.1548698689917; 
 Mon, 28 Jan 2019 10:04:49 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:49 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 05/14] clk: meson: move parm out of clkc
Date: Mon, 28 Jan 2019 19:04:21 +0100
Message-Id: <20190128180430.28689-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100451_715434_BFD12D84 
X-CRM114-Status: GOOD (  13.01  )
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
 drivers/clk/meson/clkc.h | 34 +----------------------------
 drivers/clk/meson/parm.h | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 33 deletions(-)
 create mode 100644 drivers/clk/meson/parm.h

diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 35768c2327ba..58a343fa94e6 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -9,39 +9,7 @@
 
 #include <linux/clk-provider.h>
 #include "clk-regmap.h"
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
+#include "parm.h"
 
 struct pll_params_table {
 	u16		m;
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
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
