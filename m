Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52123C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208E420859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qji2bVl2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Cr+qjYQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208E420859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D4ywJAXdtb1z49+PYSf/kxBea5KJwRCTWZINx9hZYbQ=; b=qji2bVl2uC6pXi
	AU8kOZLj3YHWlNfUoZwvN/LqF0NBmpQyBZ0TvwrPhAm7qNfMLgUg/ydGFJDtNG/K7Y/6b+1YszlJe
	uj7vXu7+bTDAOt5F7tmWGvreUirVp+ijVwB45tbZ+eRQcVHtsBnSP61KA5LniYuoDyZxRzpKWvq2O
	t14DSpFcIlQD7kf5+HiD/ooD2s8GwUe4KxblLCNYO+hTgjiWgxMzBQZizmmPd6/mABapwlhmiWb3Y
	lXqzKre/QOyuIod4r+VxShXdoZ+N1lGFmkSf68AKs+WO/MCz9wqav0tPJ8w4GD39wfdO58sd4oLGr
	Ij1PuI0chBOsvv5lHIrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpQ4-0003n6-DD; Wed, 16 Jan 2019 17:56:04 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpOy-0001Zv-KH
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:54:58 +0000
Received: by mail-wm1-x342.google.com with SMTP id r24so1635561wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ON9b15ZwfrikGupCu78N3jweJWBpOTUz81iElHrpQ5c=;
 b=Cr+qjYQ0PyPM428mvNPohQRIdPlfqXNvo6QmAkqDsxAuTgJPVN1CdEgT/mdZupdTTF
 Cx6mPlO5LNu8mmOH/G4QwpFFRQxATPGzn4wyTlxZ5WccD/Bc3sS31WQUbRnPAXjeHH0P
 kIrduBZkFinQ18MHYrpj1JGGD8s5SJPZUD7YS4WFK3pv1TGNL/AvGR2dJSB7PKaNcOcT
 HcsGr00BeYwdmyOzmYfvNP74ivnXQFx+Mp2/rLXTrRpOIa4n/wtChFUiIvEFqdqLEi+i
 oPAKD4blrjvqbWNlhKV7TB5c4GZU+uJg+SZmyLtgzMhHIlzL2DpOJZ1BSS5ir6H3eR7W
 m3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ON9b15ZwfrikGupCu78N3jweJWBpOTUz81iElHrpQ5c=;
 b=ie5yHZGRMvmYc2WCYk1+13p+v72P2DwxU9epCj063aWdelQoBh/HAXIpa2dw1eIGdc
 o5j7hGrCeNnZWANMQTkZYNb7D0zcq3R9iMqYvEwbZncPoIyMsrbaKcAPQlOX11nrivqj
 ifXWP0xBKx1wJoXijCeo5fsg8JH8qneErXHqv9pN1WzGAAUkCkSUPh6kppM5qag+Ut1z
 7x+ikSrHTsSb/XqOEDAlJrPpBVJ5JKWigtzzNhN/OczTw7d9kLMw3LRMAKdzd43FKWOA
 dFWvRdvDRhctlXwE0k8HB32T41iY/D9UTdqsK3K//eJI7RNItP/UTp9Re7n9qwsmWf+m
 l3vw==
X-Gm-Message-State: AJcUukfxJc7ge/ODvY9KbW/MzF7ZCb+tKJmGCyaGUYApOhb6zKGoIFQR
 l2AJaqjnEYOrpK4cgnrpzMw4Gg==
X-Google-Smtp-Source: ALg8bN7ilB2A3dd+B4h7VhDCTEwaseWaYU/mcfc5QyT9hjbGEwuYWNKyK7f3cJC99pvYaFMxj36IVw==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr8233044wmc.129.1547661292863; 
 Wed, 16 Jan 2019 09:54:52 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id z9sm68703861wrs.63.2019.01.16.09.54.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 09:54:52 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] clk: meson: ao-clkc: claim clock controller input clocks
 from DT
Date: Wed, 16 Jan 2019 18:54:35 +0100
Message-Id: <20190116175435.4990-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116175435.4990-1-jbrunet@baylibre.com>
References: <20190116175435.4990-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_095456_856043_4E0064F7 
X-CRM114-Status: GOOD (  16.33  )
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

Instead of relying on a fixed names for the differents input clocks
of the controller, get them through DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-aoclk.c   | 22 +++++++++++++++-----
 drivers/clk/meson/gxbb-aoclk.c  | 25 ++++++++++++++++------
 drivers/clk/meson/meson-aoclk.c | 37 ++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson-aoclk.h | 12 +++++++++--
 4 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index 5f518be144ce..5701f5840b75 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -16,6 +16,8 @@
 #include "meson-aoclk.h"
 #include "axg-aoclk.h"
 
+#define IN_PREFIX "ao-in-"
+
 /*
  * AO Configuration Clock registers offsets
  * Register offsets from the data sheet must be multiplied by 4.
@@ -38,7 +40,7 @@ static struct clk_regmap axg_aoclk_##_name = {				\
 	.hw.init = &(struct clk_init_data) {				\
 		.name =  "axg_ao_" #_name,				\
 		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ "clk81" },		\
+		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
 		.num_parents = 1,					\
 		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
@@ -60,7 +62,7 @@ static struct clk_regmap axg_aoclk_cts_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_oscin",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -167,7 +169,7 @@ static struct clk_regmap axg_aoclk_cts_rtc_oscin = {
 		.name = "axg_ao_cts_rtc_oscin",
 		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "axg_ao_32k",
-						  "axg_ext_32k" },
+						  IN_PREFIX "ext_32k-0" },
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -183,7 +185,7 @@ static struct clk_regmap axg_aoclk_clk81 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "axg_ao_clk81",
 		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = (const char *[]){ "clk81",
+		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk",
 						  "axg_ao_cts_rtc_oscin"},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
@@ -199,7 +201,8 @@ static struct clk_regmap axg_aoclk_saradc_mux = {
 	.hw.init = &(struct clk_init_data){
 		.name = "axg_ao_saradc_mux",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "xtal", "axg_ao_clk81" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal",
+						  "axg_ao_clk81" },
 		.num_parents = 2,
 	},
 };
@@ -285,6 +288,12 @@ static const struct clk_hw_onecell_data axg_aoclk_onecell_data = {
 	.num = NR_CLKS,
 };
 
+static const struct meson_aoclk_input axg_aoclk_inputs[] = {
+	{ .name = "xtal",	.required = true  },
+	{ .name = "mpeg-clk",	.required = true  },
+	{ .name = "ext-32k-0",	.required = false },
+};
+
 static const struct meson_aoclk_data axg_aoclkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(axg_aoclk_reset),
@@ -292,6 +301,9 @@ static const struct meson_aoclk_data axg_aoclkc_data = {
 	.num_clks	= ARRAY_SIZE(axg_aoclk_regmap),
 	.clks		= axg_aoclk_regmap,
 	.hw_data	= &axg_aoclk_onecell_data,
+	.inputs		= axg_aoclk_inputs,
+	.num_inputs	= ARRAY_SIZE(axg_aoclk_inputs),
+	.input_prefix	= IN_PREFIX,
 };
 
 static const struct of_device_id axg_aoclkc_match_table[] = {
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 5fa57b623b8f..510b6a7d2f18 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -9,6 +9,8 @@
 #include "meson-aoclk.h"
 #include "gxbb-aoclk.h"
 
+#define IN_PREFIX "ao-in-"
+
 /* AO Configuration Clock registers offsets */
 #define AO_RTI_PWR_CNTL_REG1	0x0c
 #define AO_RTI_PWR_CNTL_REG0	0x10
@@ -27,7 +29,7 @@ static struct clk_regmap _name##_ao = {					\
 	.hw.init = &(struct clk_init_data) {				\
 		.name = #_name "_ao",					\
 		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ "clk81" },		\
+		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
 		.num_parents = 1,					\
 		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
@@ -48,7 +50,7 @@ static struct clk_regmap ao_cts_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_cts_oscin",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -155,9 +157,9 @@ static struct clk_regmap ao_cts_rtc_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_cts_rtc_oscin",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "ext_32k_0",
-						  "ext_32k_1",
-						  "ext_32k_2",
+		.parent_names = (const char *[]){ IN_PREFIX "ext-32k-0",
+						  IN_PREFIX "ext-32k-1",
+						  IN_PREFIX "ext-32k-2",
 						  "ao_32k" },
 		.num_parents = 4,
 		.flags = CLK_SET_RATE_PARENT,
@@ -174,7 +176,7 @@ static struct clk_regmap ao_clk81 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_clk81",
 		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = (const char *[]){ "clk81",
+		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk",
 						  "ao_cts_rtc_oscin" },
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
@@ -257,6 +259,14 @@ static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
 	.num = NR_CLKS,
 };
 
+static const struct meson_aoclk_input gxbb_aoclk_inputs[] = {
+	{ .name = "xtal",	.required = true,  },
+	{ .name = "mpeg-clk",	.required = true,  },
+	{. name = "ext-32k-0",	.required = false, },
+	{. name = "ext-32k-1",	.required = false, },
+	{. name = "ext-32k-2",	.required = false, },
+};
+
 static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(gxbb_aoclk_reset),
@@ -264,6 +274,9 @@ static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.num_clks	= ARRAY_SIZE(gxbb_aoclk),
 	.clks		= gxbb_aoclk,
 	.hw_data	= &gxbb_aoclk_onecell_data,
+	.inputs		= gxbb_aoclk_inputs,
+	.num_inputs	= ARRAY_SIZE(gxbb_aoclk_inputs),
+	.input_prefix	= IN_PREFIX,
 };
 
 static const struct of_device_id gxbb_aoclkc_match_table[] = {
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 258c8d259ea1..7b9d194ccc3b 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -14,7 +14,7 @@
 #include <linux/reset-controller.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
-#include "clk-regmap.h"
+#include <linux/slab.h>
 #include "meson-aoclk.h"
 
 static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
@@ -31,6 +31,37 @@ static const struct reset_control_ops meson_aoclk_reset_ops = {
 	.reset = meson_aoclk_do_reset,
 };
 
+static int meson_aoclkc_register_inputs(struct device *dev,
+					struct meson_aoclk_data *data)
+{
+	struct clk_hw *hw;
+	char *str;
+	int i;
+
+	for (i = 0; i < data->num_inputs; i++) {
+		const struct meson_aoclk_input *in = &data->inputs[i];
+
+		str = kasprintf(GFP_KERNEL, "%s%s", data->input_prefix,
+				in->name);
+		if (!str)
+			return -ENOMEM;
+
+		hw = meson_clk_hw_register_input(dev, in->name, str, 0);
+		kfree(str);
+
+		if (IS_ERR(hw)) {
+			if (!in->required && PTR_ERR(hw) == -ENOENT)
+				continue;
+			else if (PTR_ERR(hw) != -EPROBE_DEFER)
+				dev_err(dev, "failed to register input %s\n",
+					in->name);
+			return PTR_ERR(hw);
+		}
+	}
+
+	return 0;
+}
+
 int meson_aoclkc_probe(struct platform_device *pdev)
 {
 	struct meson_aoclk_reset_controller *rstc;
@@ -53,6 +84,10 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
+	ret = meson_aoclkc_register_inputs(dev, data);
+	if (ret)
+		return ret;
+
 	/* Reset Controller */
 	rstc->data = data;
 	rstc->regmap = regmap;
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index ab2819e88922..0758b35d4427 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -13,14 +13,22 @@
 
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
-#include "clk-regmap.h"
+#include "clkc.h"
+
+struct meson_aoclk_input {
+	const char *name;
+	bool required;
+};
 
 struct meson_aoclk_data {
 	const unsigned int			reset_reg;
 	const int				num_reset;
 	const unsigned int			*reset;
-	int					num_clks;
+	const int				num_clks;
 	struct clk_regmap			**clks;
+	const int				num_inputs;
+	const struct meson_aoclk_input		*inputs;
+	const char				*input_prefix;
 	const struct clk_hw_onecell_data	*hw_data;
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
