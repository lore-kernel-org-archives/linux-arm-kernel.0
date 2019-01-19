Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EFC61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:51:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A70E2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DH5sc4Nj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bqiAuIbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iNTlb4MYy31AJgqBE3PjbpPbSML/2rbbaP9PTi0+5Wg=; b=DH5sc4NjNWFZ3O
	Box1ZylfsunUvRlO+t3t43sk+iVKnfzbIB7+IMoccx/6AacNwVTl8EUrS2nHvedXPZSWmz2ur9ZPY
	DOcAF0df4R4k1aP6aP2i6TNAGXlhUjevSFMNB0gwqednEcrWTooP/w6EvzShl1AJN80ZgGQqKzoB2
	5KHSMKYNksFxfyivN1cN0PtPWDjIDrXpYG5g/GPRaqhpFQQ5SYh5I3J6t+O6JPSfG/pCwbacoyTo0
	qGSvtDLI2A96dKKhO8By0sYnWlTpfv+lolbsuBtebZRqQb5m93jopdD562KF98rQO7MwC8g6GCDuq
	gGzxL2fYRdThX/AJbQvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkxac-0004TR-Ad; Sat, 19 Jan 2019 20:51:38 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkxaW-0004R4-T3; Sat, 19 Jan 2019 20:51:34 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so7445892wmc.5;
 Sat, 19 Jan 2019 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d9TVCi4BNICq2gxmx5zxYBJwQZn7VtKY6OR4lKjIRLA=;
 b=bqiAuIbnn3kzSJAlg+3/H4JKE6zmYpS6OR2AWZhTAlg5e5WpOPBT4WCVAalnS/xjWb
 dZ9KTYnZ5NeL24rlJXCpeosLzWzg2o8Fsxnd92N9HLT+MHn8FEYJIfF65i5o/xeqyFSK
 4uTgE7k6NmZY1kX1l4IKf4xjAD1184UaJo4liM3U7koVs7W8j0NGOQF98OulmvComHnZ
 YN3jPxYWn24htRbaPU860/zoiMSevMvSoe0xrQlkl/8FEOKJTFecVNHLJGj1oZyH3Ll+
 hBh9yDUzuPz0m/URo2tHjTh21Sr/GXq50IQuYoK7qCO/RVRAOssaWGMLDwNM4G5SoCYM
 cmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d9TVCi4BNICq2gxmx5zxYBJwQZn7VtKY6OR4lKjIRLA=;
 b=XFFK2zG2EAWtdEn++vzh43gDZsXxrAxq98/726eaChZftPiDepMWddDRf55ATv23uX
 1Wv2v8zP9C65AmG4M+yUezdI/0j5vJbB5eZoV9NgyItOfROTTOyKcNynOJX6cVZFoDsk
 Dn0rbxS5gqfqcJd+ZYxYsB9jTO7E+TqmyYg0sCs7aZrQSQCFufpL1cz4sWYyvQDbvgUp
 l2MG9gFDGeh4B+12EwFf6hXik+jRf3zAZ10vCJLst5H1WoibXLywAJZhswMontssv9St
 aZOR0/KC43g4JZ438870Jt+IshUf1YmwZY+G5jqiD+WbBkTuzBuMlOGhL4260m3tWT4c
 C3+Q==
X-Gm-Message-State: AJcUukfNA34ack6Zkw/Z5PWM0wX2NOVc5FrMP2WzDzxenBofTIY/NpKB
 5xyznseJv7UAyuWYskXJP6wJVwhz
X-Google-Smtp-Source: ALg8bN46fAbumI7GKlnWvTT6AZEONa7xuPEn/aobI3ZQImj8PLnoZsamGNELCvALaFNt1ks2HSHPYw==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr18638098wme.20.1547931090309; 
 Sat, 19 Jan 2019 12:51:30 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A8100FDA9BD4E9DEACC2C.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:fda9:bd4e:9dea:cc2c])
 by smtp.googlemail.com with ESMTPSA id 10sm58176662wmy.40.2019.01.19.12.51.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 12:51:29 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
 jbrunet@baylibre.com
Subject: [PATCH v2 2/2] clk: meson: meson8b: fix the naming of the APB clocks
Date: Sat, 19 Jan 2019 21:51:21 +0100
Message-Id: <20190119205121.9621-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190119205121.9621-1-martin.blumenstingl@googlemail.com>
References: <20190119205121.9621-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_125132_933628_56DED29A 
X-CRM114-Status: GOOD (  12.14  )
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

Fixes: a7d19b05ce817d ("clk: meson: meson8b: add the CPU clock post divider clocks")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 26 +++++++++++++-------------
 drivers/clk/meson/meson8b.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 748552c5f6c8..5136300c7915 100644
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
@@ -1910,8 +1910,8 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
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
@@ -2092,8 +2092,8 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
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
@@ -2261,8 +2261,8 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
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
index f212e2304ff5..b8c58faeae52 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -92,7 +92,7 @@
 #define CLKID_CPU_CLK_DIV6	120
 #define CLKID_CPU_CLK_DIV7	121
 #define CLKID_CPU_CLK_DIV8	122
-#define CLKID_ABP_SEL		123
+#define CLKID_APB_SEL		123
 #define CLKID_PERIPH_SEL	125
 #define CLKID_AXI_SEL		127
 #define CLKID_L2_DRAM_SEL	129
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
