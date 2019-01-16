Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52939C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2423F20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dfWCVLQZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WqWEQS4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423F20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FtTkJcZ/wEjELLIQxeQoCxKn+jy+K/MOUWyaD/qVjhs=; b=dfWCVLQZCfztBe
	PyKHtL8tHfk/oGw1R4RE2v5zHZ6wD143fkQHSut31kQJioMO55n5rTway/7VJGomXaOd6o8Qvy6sy
	l8ExiMwPqa+nXjPydi1DskuA5HdmEGy2RCxtJyA9rqNcxN434ca9QYKq+aetyuEDpg7ixV3jfwpZR
	Gdq6kzSfN/YUnbIVev34IN/43UjJZGZfmwDRDRdvq/4SOohFjMH2tfB+9v97h9oyEIFkjS8Gbr6Vs
	QZRZrPY4kN6vYjOtDBxZPA0xLiyTdrlvmL6cy16Ygj1HmYxoVbzGm8gd/VWQsq25RjKQ1N5M2lEyf
	z/iyfEZeAS9j71JdjkAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpPL-0002f1-Dy; Wed, 16 Jan 2019 17:55:19 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpOw-0001Zk-IF
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:54:58 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so7980105wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZEFgIUtqQbsi+JQedq7tZ44e0QX9Tj/+bq0nOMFDQxo=;
 b=WqWEQS4l3cv9mvkBmJx/pU7rAbx39S1J9STqryyUF160UnzNMbPRNAcGFoADcjh/ai
 Y0HLj5rezE12Y6SqrSHVyRQ2DHNRky91VZn2GOpWnO88dK9uwAWYw3TT3L7RVMVhpvjr
 MPRdStIa7rih0uehNegWLknAbL0M9aiOFj9VZqIFHkldwVpKHwhnXoJgeMti4ucZJ2ah
 a6GXdrNWVrcrEayZVSHigs0qdba61s6zSsQxJuCFj4aMygen0O752BWVTrr38GKD/vaM
 eaZpYv1QxEOcov3Ih3JAsae5nZSmzaRUX16e2vxLF+BdETtHcF5IrwxcZQpBz69pwxql
 +Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZEFgIUtqQbsi+JQedq7tZ44e0QX9Tj/+bq0nOMFDQxo=;
 b=RCkIepPwjqGWhBVQi8VhyJnypx6458Y9teQmR8/FiOm0LcXNn7qTR/EcOSwLzZESkx
 GVa4F9KWT7bG2aTp20hQQAJWmQRmPE/Sl7owhPVLeozvrrcR9So9kie+xqGfEsXOYwRA
 F5tOsWgRJXtFMi843gBuRAaDTTRt7gGtQWjnA0ALrE1t7Y2R4Iw4Z6mnPcdPWTIKjRrI
 Nz9zqh/y0d2i+OE6k1KtSB+wDkLmjTS+oAQF57RURQJIJ/5cjVgetnB6sCenLZ1h20sk
 k8Jq2HxR0kCd24LRKNC4O0DT20ldIAg7GVHDs5Ag80v5NLuNtkyhtyeDQaxJUBrohATJ
 8Gcw==
X-Gm-Message-State: AJcUukfMomvS3XKi8qZc7j0fGH1LSgBn9MJ1IznbMXmE72lij4uCUwnP
 oWhhfaQCOkOPNeBVHhuVkwlD+E8AWDY=
X-Google-Smtp-Source: ALg8bN7fgEmFsOaWhxae7UzX7ACAptcBtXcZsD04VDB8B1iFcXClSYLM2Tw0wJKR0vfbyLTL8so8vg==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr8528017wrq.16.1547661290420; 
 Wed, 16 Jan 2019 09:54:50 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id z9sm68703861wrs.63.2019.01.16.09.54.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 09:54:49 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] clk: meson: gxbb: claim clock controller input clock from
 DT
Date: Wed, 16 Jan 2019 18:54:33 +0100
Message-Id: <20190116175435.4990-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116175435.4990-1-jbrunet@baylibre.com>
References: <20190116175435.4990-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_095454_708594_5AEBB8CA 
X-CRM114-Status: GOOD (  15.79  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 patchwork-bot+notify@kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Instead of relying on a fixed name for the xtal clock, claim the
controller input clock trough DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 65f2599e5243..ecf9a8f6281c 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -16,6 +16,8 @@
 #include "gxbb.h"
 #include "clk-regmap.h"
 
+#define IN_PREFIX "ee-in-"
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static const struct pll_params_table gxbb_gp0_pll_params_table[] = {
@@ -118,7 +120,7 @@ static struct clk_regmap gxbb_fixed_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -148,7 +150,7 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll_pre_mult",
 		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -241,7 +243,7 @@ static struct clk_regmap gxl_hdmi_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 		/*
 		 * Display directly handle hdmi pll registers ATM, we need
@@ -378,7 +380,7 @@ static struct clk_regmap gxbb_sys_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -439,7 +441,7 @@ static struct clk_regmap gxbb_gp0_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -491,7 +493,7 @@ static struct clk_regmap gxl_gp0_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -789,7 +791,7 @@ static struct clk_regmap gxbb_mpll2 = {
 
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
-	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
+	IN_PREFIX "xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
 	"fclk_div3", "fclk_div5"
 };
 
@@ -852,7 +854,7 @@ static struct clk_regmap gxbb_sar_adc_clk_sel = {
 		.name = "sar_adc_clk_sel",
 		.ops = &clk_regmap_mux_ops,
 		/* NOTE: The datasheet doesn't list the parents for bit 10 */
-		.parent_names = (const char *[]){ "xtal", "clk81", },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal", "clk81", },
 		.num_parents = 2,
 	},
 };
@@ -891,7 +893,7 @@ static struct clk_regmap gxbb_sar_adc_clk = {
  */
 
 static const char * const gxbb_mali_0_1_parent_names[] = {
-	"xtal", "gp0_pll", "mpll2", "mpll1", "fclk_div7",
+	IN_PREFIX "xtal", "gp0_pll", "mpll2", "mpll1", "fclk_div7",
 	"fclk_div4", "fclk_div3", "fclk_div5"
 };
 
@@ -1153,7 +1155,7 @@ static struct clk_regmap gxbb_32k_clk = {
 };
 
 static const char * const gxbb_32k_clk_parent_names[] = {
-	"xtal", "cts_slow_oscin", "fclk_div3", "fclk_div5"
+	IN_PREFIX "xtal", "cts_slow_oscin", "fclk_div3", "fclk_div5"
 };
 
 static struct clk_regmap gxbb_32k_clk_sel = {
@@ -1172,7 +1174,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 };
 
 static const char * const gxbb_sd_emmc_clk0_parent_names[] = {
-	"xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
+	IN_PREFIX "xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
 
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
@@ -2138,7 +2140,7 @@ static struct clk_regmap gxbb_hdmi_tx = {
 /* HDMI Clocks */
 
 static const char * const gxbb_hdmi_parent_names[] = {
-	"xtal", "fclk_div4", "fclk_div3", "fclk_div5"
+	IN_PREFIX "xtal", "fclk_div4", "fclk_div3", "fclk_div5"
 };
 
 static struct clk_regmap gxbb_hdmi_sel = {
@@ -2285,7 +2287,7 @@ static struct clk_regmap gxbb_vdec_hevc = {
 static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
 				    9, 10, 11, 13, 14, };
 static const char * const gen_clk_parent_names[] = {
-	"xtal", "vdec_1", "vdec_hevc", "mpll0", "mpll1", "mpll2",
+	IN_PREFIX "xtal", "vdec_1", "vdec_hevc", "mpll0", "mpll1", "mpll2",
 	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7", "gp0_pll",
 };
 
@@ -3085,6 +3087,7 @@ static const struct of_device_id clkc_match_table[] = {
 static int gxbb_clkc_probe(struct platform_device *pdev)
 {
 	const struct clkc_data *clkc_data;
+	struct clk_hw *input;
 	struct regmap *map;
 	int ret, i;
 	struct device *dev = &pdev->dev;
@@ -3100,6 +3103,14 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 		return PTR_ERR(map);
 	}
 
+	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
+	if (IS_ERR(input)) {
+		ret = PTR_ERR(input);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get input clock");
+		return ret;
+	}
+
 	/* Populate regmap for the common regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(gx_clk_regmaps); i++)
 		gx_clk_regmaps[i]->map = map;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
