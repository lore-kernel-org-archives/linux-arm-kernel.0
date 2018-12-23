Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB4C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:59:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24212184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cnwddpuv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="r0K3Jld5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24212184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjrgCrbDH3KQbEy2vzqHuJmjmGiF6/C0Fc2M4DbGgPI=; b=Cnwddpuv1FRGeH
	xtGPJvs+BOmy6jh1yj99vT2s5YW95tjkTle0Dlzytk1LF+1U9B3G85+6mBRjjSxvKp9FVBbCDIaHy
	OW7MlRgSVef4ri/yNTXS467+bUB7s6XNytXk1PWbfjMIKfJtfWf8tCqdxvpLHIsYO+R82Krg0/UCp
	gDsBg1tx49sgfDzT1nB+rKWhytpjjYWbNrHVQjkc+TfkYUCXadsdFcPfjU4ewbUBHMNV4/mEEApcU
	eLNxBOT7DZubiy/U4jjTr74zlymFUjK1plBK2Y0ec46bh6TAh4juzy/44LrvRAarxyqYIGkw0S/Eq
	HOifjLhgIgqr8Vdwa9Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbDeN-0002cB-LQ; Sun, 23 Dec 2018 23:59:15 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbDeD-0002WX-EG
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 23:59:06 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so10302370wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 23 Dec 2018 15:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gXsYZ9CwBHYIPypPRLB1B250Ytze3V+PvoB4AWuujI=;
 b=r0K3Jld5+UwuEw/TsBdshdADtaE0BcRW0RlypsR+vulO9DLJUs1WHUNH1SDNMTvgso
 Rp0SkHEwD+bIB8g0qwDwAqSl3f8OAASNLHdTP8874UK7v54GikdCSNirgeHBdKogdSda
 IYdjBqY+1cYdxbYc3qGOdUOoKDS1HOGklr31Dos1KmBdCuqfB+VMPHER0B0oBo5zfgHE
 SKYGdBRAf31SlfGfiDdi8mJ8AX7qsVctYoTmq2bbOjmCkKI1DG3pDB6mKDbVKYkYxJpj
 cfg3RQwMlJ4fWF9a4aaJ4rIaoaDjni2pgKFRPoUzSmKR1mkuI6lMyd25tBth2GvI1AhB
 JYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7gXsYZ9CwBHYIPypPRLB1B250Ytze3V+PvoB4AWuujI=;
 b=gHMt48vm8XFtVN5PsbAA5CYWkXkacULUUdehVxtFiaDIjCgw304Eag2TpvcRLpgbel
 2OlvzFdzrqmxjt9lJF/y9pnBeG/O26Ng2hegNnAlCsp6TASXlbAYbfHCcjKwOxU448Da
 tNv97+b+1AXkkO9uAPVbTVMqWfZb9AGMvtRInBrp2azABBoxCHMyGsrt6BgpMWVscDZh
 o4YNy0sTAlUuX9wOP2EYJ1DyuKktnNY5ljmhvFUrLdslOFaei77cWxnFqrTj9a9QqpmV
 OE5lkI039CcHj/ltQOZ1BS8Fv9G/5Wrws8PpMU5MBnm+080DNWHApuE4E8TW4/Bu1q+7
 GJeA==
X-Gm-Message-State: AJcUukcpgMl4U2ILdoLZPUW6nCyeSqr0DqjhX0yJLA1Lqf8cAzjGEhQh
 5gO9kcWhKZnqzWgfQv5MkMo=
X-Google-Smtp-Source: ALg8bN5ONCbI6yuVMym/OHnQZE6EtSmyPQ2M3l0SXAy0aODhRADuTQ83LwuTk8tJA8bsC1qwW1WhbQ==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr9389407wrd.20.1545609532398;
 Sun, 23 Dec 2018 15:58:52 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD711B0006842FD8F1E9F13DE.dip0.t-ipconnect.de.
 [2003:dc:d711:b000:6842:fd8f:1e9f:13de])
 by smtp.googlemail.com with ESMTPSA id s1sm28527174wro.9.2018.12.23.15.58.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Dec 2018 15:58:51 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jbrunet@baylibre.com,
	narmstrong@baylibre.com
Subject: [PATCH 1/1] clk: meson: meson8b: fix naming of the APB clocks
Date: Mon, 24 Dec 2018 00:58:36 +0100
Message-Id: <20181223235836.12466-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181223235836.12466-1-martin.blumenstingl@googlemail.com>
References: <20181223235836.12466-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_155905_476549_22858832 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: sboyd@kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix a typo in the APB clock names by renaming them from "abp" to "apb".
No functional changes.

Fixes: 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU post dividers")
Fixes: a7d19b05ce817d ("clk: meson: meson8b: add the CPU clock post divider clocks")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c              | 22 +++++++++++-----------
 drivers/clk/meson/meson8b.h              |  2 +-
 include/dt-bindings/clock/meson8b-clkc.h |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 950d0e548c75..fa15ba9f4327 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -803,16 +803,16 @@ static struct clk_fixed_factor meson8b_cpu_clk_div8 = {
 	},
 };
 
-static u32 mux_table_abp[] = { 1, 2, 3, 4, 5, 6, 7 };
-static struct clk_regmap meson8b_abp_clk_sel = {
+static u32 mux_table_apb[] = { 1, 2, 3, 4, 5, 6, 7 };
+static struct clk_regmap meson8b_apb_clk_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL1,
 		.mask = 0x7,
 		.shift = 3,
-		.table = mux_table_abp,
+		.table = mux_table_apb,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "abp_clk_sel",
+		.name = "apb_clk_sel",
 		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "cpu_clk_div2",
 						  "cpu_clk_div3",
@@ -825,16 +825,16 @@ static struct clk_regmap meson8b_abp_clk_sel = {
 	},
 };
 
-static struct clk_regmap meson8b_abp_clk_gate = {
+static struct clk_regmap meson8b_apb_clk_gate = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL1,
 		.bit_idx = 16,
 		.flags = CLK_GATE_SET_TO_DISABLE,
 	},
 	.hw.init = &(struct clk_init_data){
-		.name = "abp_clk_dis",
+		.name = "apb_clk_dis",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_names = (const char *[]){ "abp_clk_sel" },
+		.parent_names = (const char *[]){ "apb_clk_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -1781,8 +1781,8 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CPU_CLK_DIV6]	    = &meson8b_cpu_clk_div6.hw,
 		[CLKID_CPU_CLK_DIV7]	    = &meson8b_cpu_clk_div7.hw,
 		[CLKID_CPU_CLK_DIV8]	    = &meson8b_cpu_clk_div8.hw,
-		[CLKID_ABP_SEL]		    = &meson8b_abp_clk_sel.hw,
-		[CLKID_ABP]		    = &meson8b_abp_clk_gate.hw,
+		[CLKID_APB_SEL]		    = &meson8b_apb_clk_sel.hw,
+		[CLKID_APB]		    = &meson8b_apb_clk_gate.hw,
 		[CLKID_PERIPH_SEL]	    = &meson8b_periph_clk_sel.hw,
 		[CLKID_PERIPH]		    = &meson8b_periph_clk_gate.hw,
 		[CLKID_AXI_SEL]		    = &meson8b_axi_clk_sel.hw,
@@ -1943,8 +1943,8 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_fixed_pll_dco,
 	&meson8b_hdmi_pll_dco,
 	&meson8b_sys_pll_dco,
-	&meson8b_abp_clk_sel,
-	&meson8b_abp_clk_gate,
+	&meson8b_apb_clk_sel,
+	&meson8b_apb_clk_gate,
 	&meson8b_periph_clk_sel,
 	&meson8b_periph_clk_gate,
 	&meson8b_axi_clk_sel,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 87fba739af81..3cac2be7138b 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -91,7 +91,7 @@
 #define CLKID_CPU_CLK_DIV6	120
 #define CLKID_CPU_CLK_DIV7	121
 #define CLKID_CPU_CLK_DIV8	122
-#define CLKID_ABP_SEL		123
+#define CLKID_APB_SEL		123
 #define CLKID_PERIPH_SEL	125
 #define CLKID_AXI_SEL		127
 #define CLKID_L2_DRAM_SEL	129
diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 5fe2923382d0..cd11628f50f8 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -103,7 +103,7 @@
 #define CLKID_MPLL1		94
 #define CLKID_MPLL2		95
 #define CLKID_NAND_CLK		112
-#define CLKID_ABP		124
+#define CLKID_APB		124
 #define CLKID_PERIPH		126
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
