Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD64C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4E621783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H4r0h8Sf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8Tt52Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4E621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VfteItw+RH4BgLwcFMgYE0B76eXMwo8SdVi0JUGzLZw=; b=H4r0h8SfRCfp/xiKexJ2s3XJWo
	tEK1RxJr4hOY7vcqFRAzG1GTk3guQszKlbaLU5kYqn0u91HxuePdihd6kIf01S/cOqoRtaicBzDDw
	TlTN+yBs4ZO4hs1sCbv06r7xQMOrRTWTEv0WNQYqwfkPGEb44KfOuaX9A9Vw7Yvl6XgAiU5XN/zuY
	xRX9FYATFM6UaxGV/lEVxuqaEVcNMjAB/JoQAA62XVjwc+Q7OWGWiuvJuHDoWFRaBTH0ITVqWF3aR
	375U8luS6cx7zqCaTRzlod/32sLpV8eq2axVNEuTigSJLPVc8pLUsLsc41wyiErG5Fx2m4tqILRGU
	vWofZ0aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2jK-0003EL-Di; Mon, 31 Dec 2018 18:56:02 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2j3-0002yW-Mk
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:55:48 +0000
Received: by mail-pl1-x644.google.com with SMTP id z23so12904484plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wGON2lybsGy7FC0OgCUYudVtpokObJD+vq+U001MecQ=;
 b=X8Tt52JcCR8ZkeN2DDakfZzHCPRVV4UzdKgl85bFhx1Btuy/aWNp56Wa1wbQuEAxvX
 /6FPeBENCGfp9th/naRoCzH1Em3pitOhqvpb8ASdME5jGaStYrLVfWR45Km9V/MoK3RH
 9hQfv8eqdpXnFgZsEYmGWIB+ds0g8icOp38qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wGON2lybsGy7FC0OgCUYudVtpokObJD+vq+U001MecQ=;
 b=Ie6UrczIf+s2z+Ipt4jkC3oRL8oOrxG8cUcRvqN8V4z96e8jHneutz/M52rrEaUFyO
 AKadbXlptUP7mS19NZr08YEr/Q3GpB3O0TTrp14twYAgGZkVRCG45jbI7zh2AdudEnX8
 PIOKNjSlN5C2wBBm9S24BPcvDVdHQUSUemvI1+L+o3khvKAccI8tUURNJCQK7upivKAN
 iNN8S+/3yRehQhLeLbMrwEZvchFbTq3MVuMmjUCdns5YDVsVGp565VtRMpSKWRhyLAEZ
 PaSbnSkqRpMxo+W09MxXLN12sSXGrvCGtANBcHlKengKlRQ594zZge3ZeyCMdXn0nZvv
 s9MQ==
X-Gm-Message-State: AJcUukeOqZ5T3hptR990qYuKytsgb3CYptl8wQWkXAnDFwakpLmE7rPQ
 CMPmwKON+eRz2IK4plAfw3gS
X-Google-Smtp-Source: ALg8bN41CVinuICeb02ZWQO42BBaPPILhSZY7fz9tt82jxIo6da0gpuWlRJ39SrdVbBINotWx8zlpA==
X-Received: by 2002:a17:902:c05:: with SMTP id
 5mr38534757pls.155.1546282544662; 
 Mon, 31 Dec 2018 10:55:44 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
 by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:55:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Subject: [PATCH 1/6] clk: actions: Add configurable PLL delay
Date: Tue,  1 Jan 2019 00:25:12 +0530
Message-Id: <20181231185517.18517-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_105546_036568_354243A0 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
