Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9862C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B915920859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UcKJ7qPG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mj2BBHIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B915920859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZOZx8MnhHcp7AkqJQUN9uw/Mu+7rDRkvuU8Y76DOuoY=; b=UcKJ7qPGDtu5Ga
	OsP5KBNON8Oyp9pOHhMnm169b07EIfzh58wrYZv0bXJghsX8XsfpNG7GBX/354YwMVExFIXYPVX/h
	RY6S7QcPgjIa1A0NxS7NlMYH7nhE4otyjX9K/lHI70cJx5YMet1rCYKHKz7MRWTYV6Aw9DpPC3xo4
	OX2Us1T37eN3Ar13sNAQFo2hPkAo0moprRQi/SerLOeLDCIIIcex+8llTwE1CpllJBFWsAf2BpCUT
	tcEar10tuje78ouDDGTGLK2VRe+xJcHgFP6jso5EuNafgieACMROIlKVVZtZbk485banqlWtPeAY5
	VmJSBUwo3qwWpzowokFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpPZ-0003KO-U0; Wed, 16 Jan 2019 17:55:34 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpOw-0001Zr-II
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:54:58 +0000
Received: by mail-wr1-x443.google.com with SMTP id x10so7941913wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PO1Q8Fk8a+GCvLUwshwuMPTHTCeZhTO+WtQpOuaokSk=;
 b=mj2BBHIevH3MnA+YYJaxLgYvfjLiEs7xwvpS8eBy4Q+KIhW9K0kzZvgHmPlhB9kYql
 LIEN852pKEAwbqXkayZDdiv3SV172DJxOpCr+AQ879pDB92TbpdEm4DLSmOysjeQO5mV
 Et1QgmGkSKY1FA6sk6t7z6jvCNMxZz+bi4bavw8IwkLjqhtqaBnt6tMWX8ZGVRFQs6+b
 hHL16AGYTlM0jsb8g5YpxuFTYOyUEht9EyiWyY1kXhhgDFrD5d75dYteTpdNkFhYBIF2
 SdQGEeBZeBrZlZUrWYRFnAm9OunxOKtuEJRSaadTKivnF34mgMq2fnmQK92Z7OUks+HF
 D8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PO1Q8Fk8a+GCvLUwshwuMPTHTCeZhTO+WtQpOuaokSk=;
 b=RWMTPgDdCoaZmVDuvS55jMI3COP0MS2rLo+7IDdzh35X0K6kQyXtxw9HqPqu8GTBvy
 ag6N2nwOzU+F4U88F/ryM1qFxiZe5BAmwCrMBlQuTYwxKMNAD6uCsIW3GceaeJSbjjZL
 i0OXpwZEICc3fO4FXXT35MoVe4HgR6ow1lpZjwm9ZPYSmbn2uDfIhUhfStCpYB8sTln9
 MB2Pjd298weA0XiPKg9SpbdFkQBQbnHZdzsYdrEDvDv7nBiMU4Zv6qaVN+oSJZptM55r
 SO4K9NcygF7loNdB1Z5tQeAQ3pQ5yXWu0rzeQXMhMvIiV0k2nMwEWIw1yBacrFkmkTIo
 Yt/w==
X-Gm-Message-State: AJcUukep7kNadfY4hhQeIsBuf6ROYN2b3ChlC4ZDIPq816apmPBSgJoC
 pkFXjT2AZgK8W6vSIGChOiTVVI92MMQ=
X-Google-Smtp-Source: ALg8bN4pSLxcAop3TLQnfJdwy8u6vXjFUxYUUwrvCvjCyTUjgqPxclTiE6oQvWK+dqgW+hT2jf3VJA==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr8888908wrn.264.1547661291733; 
 Wed, 16 Jan 2019 09:54:51 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id z9sm68703861wrs.63.2019.01.16.09.54.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 09:54:51 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] clk: meson: axg: claim clock controller input clock from
 DT
Date: Wed, 16 Jan 2019 18:54:34 +0100
Message-Id: <20190116175435.4990-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116175435.4990-1-jbrunet@baylibre.com>
References: <20190116175435.4990-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_095454_690869_F3FD3BB9 
X-CRM114-Status: GOOD (  15.06  )
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
 drivers/clk/meson/axg.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 792735d7e46e..1c6539eeee7c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -20,6 +20,8 @@
 #include "clkc.h"
 #include "axg.h"
 
+#define IN_PREFIX "ee-in-"
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static struct clk_regmap axg_fixed_pll_dco = {
@@ -58,7 +60,7 @@ static struct clk_regmap axg_fixed_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -113,7 +115,7 @@ static struct clk_regmap axg_sys_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -214,7 +216,7 @@ static struct clk_regmap axg_gp0_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -283,7 +285,7 @@ static struct clk_regmap axg_hifi_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "hifi_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -701,7 +703,7 @@ static struct clk_regmap axg_pcie_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -803,7 +805,7 @@ static struct clk_regmap axg_pcie_cml_en1 = {
 
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
-	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
+	IN_PREFIX "xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
 	"fclk_div3", "fclk_div5"
 };
 
@@ -852,7 +854,7 @@ static struct clk_regmap axg_clk81 = {
 };
 
 static const char * const axg_sd_emmc_clk0_parent_names[] = {
-	"xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
+	IN_PREFIX "xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
 
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
@@ -957,7 +959,7 @@ static struct clk_regmap axg_sd_emmc_c_clk0 = {
 static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
 				    9, 10, 11, 13, 14, };
 static const char * const gen_clk_parent_names[] = {
-	"xtal", "hifi_pll", "mpll0", "mpll1", "mpll2", "mpll3",
+	IN_PREFIX "xtal", "hifi_pll", "mpll0", "mpll1", "mpll2", "mpll3",
 	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7", "gp0_pll",
 };
 
@@ -1263,6 +1265,7 @@ static const struct of_device_id clkc_match_table[] = {
 static int axg_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct clk_hw *input;
 	struct regmap *map;
 	int ret, i;
 
@@ -1273,6 +1276,14 @@ static int axg_clkc_probe(struct platform_device *pdev)
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
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
