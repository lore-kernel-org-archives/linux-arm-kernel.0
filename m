Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E147420656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oLjh61eH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt5uwZj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E147420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VfteItw+RH4BgLwcFMgYE0B76eXMwo8SdVi0JUGzLZw=; b=oLjh61eHKK0ebFtJvxqCKesfpJ
	iX82mDAIEfKODMQRpqKdFoN4JkA9Xjhe+S8p+7DqzhEShWLgacfdgjm/M0zxSHUd6pwu2zn7z41AV
	vOrVowjXwcPuqKDUFCApI1vg7J7ZjmxC3rTT/pM3lRRM3rPKXgSQWBHox2kiHaXJl3AVi8idhYd70
	7yA7rztgf6sRn339oxxy2LzwfI4F713r8oWmW9f/NKNeDMgkbnqSFkNY457PAXiU7CA4xbdCADK/3
	LarUU5eHO1hJYWbdgQCbM9TubSqDo/Fb3oHu+lYTp/Zw5LCFfEZ1fdjclo9dWh4qEFWD4/zpjID9s
	5/VU0bnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFUZ-0000kT-H4; Tue, 15 Jan 2019 03:34:19 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFUJ-0000Sj-KH
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:34:06 +0000
Received: by mail-pg1-x541.google.com with SMTP id t13so586684pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 19:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wGON2lybsGy7FC0OgCUYudVtpokObJD+vq+U001MecQ=;
 b=kt5uwZj0n2jIfhdmMmww8CUoQKLY9VIyrpit7LW9KHb2Y8A+0NVIfw3j0Jb3nTwEsf
 5qi7MQ1We/Fmmg8Rkc4ZKICZFn/0yuLCBmApFxOa2eE5YgqO2os5oq8o8TtpxaSbFmuQ
 hiJe336DjVtBrAgMtEKNYL2ZywH9BXbOPsPfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wGON2lybsGy7FC0OgCUYudVtpokObJD+vq+U001MecQ=;
 b=ucxJbwH5XdK5515uo0n6clhi26A5S21dRGbFQjmOjJZfdR3LkpUw3SAx7ZLB1WUvIy
 2VUDISxSRxb6w2MPGpbiOmHqFODtVj5COZM7yHwO3diJUBQtUT7M8sHTo7d8XCCUxiZ1
 bSy/TOctsM6QORO3LOU7p03t+EkYCa3nm+S5fw/3pq0/jCWI/NDWqPAKVxhFQ/AW1C43
 e0jvrn6g5ndunVfxYRG9qoOEp2Fp7iZNcmR/fVHK46tqC0Rs9tw+zkuqopBpTpa6VJ6M
 hSt3LRF7Sw4R1zk6ZYN1St44gSGbFg/9BUWsk2i4dZQMBbYLU+xyNcl7btSEErIYPdOC
 vuEQ==
X-Gm-Message-State: AJcUukd++ehH4tVYeY6lv2IwK7iwDYZkNsGwDv/OoI8BaUquzKP8j/DN
 jThE1iPKHFRNAJFm7eTaaF7G1z7htQ==
X-Google-Smtp-Source: ALg8bN5230LUY/wn9nCxtf+4tYuSySJK3C/+zqeuTSEYcGrKHPg2vzAts66SahVhWg++8iiXT/edEw==
X-Received: by 2002:a65:4946:: with SMTP id q6mr1769075pgs.201.1547523242855; 
 Mon, 14 Jan 2019 19:34:02 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
 by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.33.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 19:34:02 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/6] clk: actions: Add configurable PLL delay
Date: Tue, 15 Jan 2019 09:03:35 +0530
Message-Id: <20190115033340.25016-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_193403_897469_B0C8F712 
X-CRM114-Status: GOOD (  14.98  )
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
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

S500 SoC requires configurable delay for different PLLs. Hence, add
a separate macro for declaring a PLL with configurable delay and also
modify the existing OWL_PLL_NO_PARENT macro to use default delay so
that no need to modify the existing S700/S900 drivers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-pll.c |  2 +-
 drivers/clk/actions/owl-pll.h | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
index 058e06d7099f..02437bdedf4d 100644
--- a/drivers/clk/actions/owl-pll.c
+++ b/drivers/clk/actions/owl-pll.c
@@ -179,7 +179,7 @@ static int owl_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	regmap_write(common->regmap, pll_hw->reg, reg);
 
-	udelay(PLL_STABILITY_WAIT_US);
+	udelay(pll_hw->delay);
 
 	return 0;
 }
diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
index 0aae30abd5dc..6fb0d45bb088 100644
--- a/drivers/clk/actions/owl-pll.h
+++ b/drivers/clk/actions/owl-pll.h
@@ -13,6 +13,8 @@
 
 #include "owl-common.h"
 
+#define OWL_PLL_DEF_DELAY	50
+
 /* last entry should have rate = 0 */
 struct clk_pll_table {
 	unsigned int		val;
@@ -27,6 +29,7 @@ struct owl_pll_hw {
 	u8			width;
 	u8			min_mul;
 	u8			max_mul;
+	u8			delay;
 	const struct clk_pll_table *table;
 };
 
@@ -36,7 +39,7 @@ struct owl_pll {
 };
 
 #define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,			\
-		   _width, _min_mul, _max_mul, _table)			\
+		   _width, _min_mul, _max_mul, _delay, _table)		\
 	{								\
 		.reg		= _reg,					\
 		.bfreq		= _bfreq,				\
@@ -45,6 +48,7 @@ struct owl_pll {
 		.width		= _width,				\
 		.min_mul	= _min_mul,				\
 		.max_mul	= _max_mul,				\
+		.delay		= _delay,				\
 		.table		= _table,				\
 	}
 
@@ -52,8 +56,8 @@ struct owl_pll {
 		_shift, _width, _min_mul, _max_mul, _table, _flags)	\
 	struct owl_pll _struct = {					\
 		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
-				     _width, _min_mul,			\
-				     _max_mul, _table),			\
+				     _width, _min_mul, _max_mul,	\
+				     OWL_PLL_DEF_DELAY,	_table),	\
 		.common = {						\
 			.regmap = NULL,					\
 			.hw.init = CLK_HW_INIT(_name,			\
@@ -67,8 +71,23 @@ struct owl_pll {
 		_shift, _width, _min_mul, _max_mul, _table, _flags)	\
 	struct owl_pll _struct = {					\
 		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
-				     _width, _min_mul,			\
-				     _max_mul, _table),			\
+				     _width, _min_mul, _max_mul,	\
+				     OWL_PLL_DEF_DELAY,	_table),	\
+		.common = {						\
+			.regmap = NULL,					\
+			.hw.init = CLK_HW_INIT_NO_PARENT(_name,		\
+					       &owl_pll_ops,		\
+					       _flags),			\
+		},							\
+	}
+
+#define OWL_PLL_NO_PARENT_DELAY(_struct, _name, _reg, _bfreq, _bit_idx,	\
+		_shift, _width, _min_mul, _max_mul, _delay, _table,	\
+		_flags)							\
+	struct owl_pll _struct = {					\
+		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
+				     _width, _min_mul,  _max_mul,	\
+				     _delay, _table),			\
 		.common = {						\
 			.regmap = NULL,					\
 			.hw.init = CLK_HW_INIT_NO_PARENT(_name,		\
@@ -78,7 +97,6 @@ struct owl_pll {
 	}
 
 #define mul_mask(m)		((1 << ((m)->width)) - 1)
-#define PLL_STABILITY_WAIT_US	(50)
 
 static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
