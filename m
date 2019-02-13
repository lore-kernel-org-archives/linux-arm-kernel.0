Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596A9222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IU1s5u1+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1WNXKCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596A9222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LAXEdkuYEdswRqpeZaXiHZEcmnhyfb1ILhc3+yshMlU=; b=IU1s5u1+sWxhkx
	esTYGgHwWt1+J7TgI0PcKuEeQUeB01ckfwIdCmTChtBzXEOYz5sO0pMP3CNsj+2OwKTAWD+m1+TBD
	3Nbqj02MUVE4WPgbyoNU62rsW0eXs1f8JOiFjSCMWvqVUFCTOlBVxyF1HUrYYUUQ+a+EkfvXy/bSz
	wgASmcwFjBYL31siQLdiig2IMG3U8Ld20ox+atiBLmRF3UcqM/rtvxsBavUOnZGEldaAwUbMLAXoG
	by3wcKUpPC4BeHY08i98xR1uQ8ZpRJSFKjq/zmeNF2dc2KtEULLoosi61241icnsohOYZH3nlHXRT
	EjhWoofcTHLVqj2KHf7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2Hh-0005RV-OF; Wed, 13 Feb 2019 21:41:37 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2HR-000593-3r
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:41:26 +0000
Received: by mail-pf1-x443.google.com with SMTP id g6so1793960pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wLmvmqHuKLo0jMVgOhqswHV98llcZw1Y6p8Tf9a/GTU=;
 b=q1WNXKCFMPXvHsH+kdD7TkDmIxQxz7Gu3pdOfEDuN3WB5/J7dGJwEssoHkOBzL0HtS
 kw0e5+VdnhaGxZ+bgfhXVR6SDCi8kaa/idKEojjauORIQp78+qAtJXXsTcwASDeAN60x
 PMLKepbIeDEIkHOGqzHZ8z4B4QUALNto96iuffAv4d86iZAyghGNFzzYC1Wa0e0w1A0V
 7U5PGPze9tg5P8Y+rywGjTqFQ/behg0w7F376uEv8Q79iyS4P5L8NR6M86T8H8hUwHXI
 HGdPr69lwNhiek1k1OI2grvcGVbCvvLCPhAyz7eRPVJlbwczMBvDHHownIeSQp2Zn4lS
 Cpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wLmvmqHuKLo0jMVgOhqswHV98llcZw1Y6p8Tf9a/GTU=;
 b=W2RJg18MeJIb+hp7qkdmWQk+PwEnctF3O9er/WtUXpHQLtCdaMY6GHjhubz0vjmcBz
 psNVy0XkqNqMBKgtLvl7HAXb1O8F+e4uGlv+m4p9h9oJiD5yUqWgrAcZNYc0n9R5dM+0
 S4sLe4YTThp3Narf9nrf9r+AjJMlhRlg6Zq51xSIz9SeWX5EZr6x7z0fudbj93qEUzet
 wuXb2Bx/nZ5MCSY9JNms1gd9b9VPDDEpQdX8srtagw1ZANbcVyIFUpqILq4laUtHZemX
 sgdXXpWqXEnr7UeJrVEyKIj/Gq9qvNU9Kyhrhc9BWncCHJkrxTW0j+nv6KopuIlc5KO3
 wSyA==
X-Gm-Message-State: AHQUAuZJeDLIdkd1UXZGZUEA/TG1LLk5lRFu8A1Gf1vX6bS9PX562uTv
 lfrK2AQskqSCJ/m3/+LEzAc=
X-Google-Smtp-Source: AHgI3IaF1fZqE0Mi2O9QOjJawD2AH4b0sAQ6qMAOlYxBBSuKw2C2dyiZHFLf/ghj1TijKIzOqxljBg==
X-Received: by 2002:a63:68ca:: with SMTP id d193mr280117pgc.53.1550094080651; 
 Wed, 13 Feb 2019 13:41:20 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.137])
 by smtp.gmail.com with ESMTPSA id w128sm335321pfw.79.2019.02.13.13.41.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 13:41:20 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/2] soc: samsung: pmu: Add the PMU data of exynos4412 to
 support low-power state
Date: Wed, 13 Feb 2019 21:40:52 +0000
Message-Id: <20190213214052.2427-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213214052.2427-1-linux.amoon@gmail.com>
References: <20190213214052.2427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134121_480645_1FB363A6 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds configration for PMU (Power Management Unit) state
tuning for exynos4412 SoC in order to enter low-power mode during
suspend power modes and help resume from suspend state.

Fixes: bfce552d0b1 ("drivers: soc: Add support for Exynos PMU driver")
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---

Changes from previous patch.
New patch to this series to support suspend and resume state

Changes have been tested on microSD card but fails to resume on cMMC.
It need to be investigated and more debuging
---
 drivers/soc/samsung/exynos4-pmu.c           | 83 +++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h | 21 ++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
index a7cdbf1aac0c..d261a0d2371e 100644
--- a/drivers/soc/samsung/exynos4-pmu.c
+++ b/drivers/soc/samsung/exynos4-pmu.c
@@ -200,10 +200,93 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static unsigned int const exynos4412_list_feed[] = {
+	EXYNOS4_ARM_CORE0_OPTION,
+	EXYNOS4_ARM_CORE1_OPTION,
+	EXYNOS4_ARM_CORE2_OPTION,
+	EXYNOS4_ARM_CORE3_OPTION,
+	EXYNOS4_ARM_COMMON_OPTION,
+	EXYNOS4_CAM_OPTION,
+	EXYNOS4_TV_OPTION,
+	EXYNOS4_MFC_OPTION,
+	EXYNOS4_G3D_OPTION,
+	EXYNOS4_LCD0_OPTION,
+	EXYNOS4_ISP_OPTION,
+	EXYNOS4_MAUDIO_OPTION,
+	EXYNOS4_GPS_OPTION,
+	EXYNOS4_GPS_ALIVE_OPTION,
+};
+
+static void exynos4412_pmu_central_seq(bool enable)
+{
+	unsigned int value;
+
+	value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	if (enable)
+		value &= ~S5P_CENTRAL_LOWPWR_CFG;
+	else
+		value |= S5P_CENTRAL_LOWPWR_CFG;
+	pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION);
+
+	value = pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
+	if (enable)
+		value &= ~S5P_CENTRAL_LOWPWR_CFG;
+	else
+		value |= S5P_CENTRAL_LOWPWR_CFG;
+	pmu_raw_writel(value, S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK);
+}
+
+static void exynos4412_pmu_init(void)
+{
+	unsigned int value;
+	int i;
+
+	/* Enable USE_STANDBY_WFI for all CORE */
+	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
+
+	/* Decides whether to use retention capability */
+	value  = pmu_raw_readl(S5P_ARM_L2_0_OPTION);
+	value &= ~EXYNOS_L2_USE_RETENTION;
+	pmu_raw_writel(value, S5P_ARM_L2_0_OPTION);
+
+	value = pmu_raw_readl(S5P_ARM_L2_1_OPTION);
+	value &= ~EXYNOS_L2_USE_RETENTION;
+	pmu_raw_writel(value, S5P_ARM_L2_1_OPTION);
+
+	/* Set PSHOLD port for output high */
+	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
+	value |= S5P_PS_HOLD_OUTPUT_HIGH;
+	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
+
+	/* Enable signal for PSHOLD port */
+	value = pmu_raw_readl(S5P_PS_HOLD_CONTROL);
+	value |= S5P_PS_HOLD_EN;
+	pmu_raw_writel(value, S5P_PS_HOLD_CONTROL);
+
+	/* Enable only SC_FEEDBACK */
+	for (i = 0; i < ARRAY_SIZE(exynos4412_list_feed); i++) {
+		value =  pmu_raw_readl(exynos4412_list_feed[i]);
+		value &= ~(EXYNOS_USE_SC_COUNTER);
+		value |= EXYNOS_USE_SC_FEEDBACK;
+		pmu_raw_writel(value, exynos4412_list_feed[i]);
+	}
+
+	exynos4412_pmu_central_seq(false);
+
+	pr_info("EXYNOS4x12 PMU Initialize\n");
+}
+
+static void exynos4412_powerdown_conf(enum sys_powerdown mode)
+{
+	exynos4412_pmu_central_seq(true);
+}
+
 const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
 };
 
 const struct exynos_pmu_data exynos4412_pmu_data = {
 	.pmu_config		= exynos4412_pmu_config,
+	.pmu_init		= exynos4412_pmu_init,
+	.powerdown_conf		= exynos4412_powerdown_conf,
 };
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 5addaf5ccbce..6beed3e669d2 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -16,6 +16,8 @@
 
 #define S5P_CENTRAL_SEQ_CONFIGURATION		0x0200
 
+#define S5P_CENTRAL_SEQ_CONFIGURATION_COREBLK   0x0240
+
 #define S5P_CENTRAL_LOWPWR_CFG			(1 << 16)
 
 #define S5P_CENTRAL_SEQ_OPTION			0x0208
@@ -347,6 +349,25 @@
 #define EXYNOS3_OPTION_USE_SC_FEEDBACK			(1 << 1)
 #define EXYNOS3_OPTION_SKIP_DEACTIVATE_ACEACP_IN_PWDN	(1 << 7)
 
+/* EXYNOS4 */
+#define EXYNOS_USE_SC_FEEDBACK					BIT(1)
+#define EXYNOS_USE_SC_COUNTER					BIT(0)
+
+#define EXYNOS4_ARM_CORE0_OPTION				0x2008
+#define EXYNOS4_ARM_CORE1_OPTION				0x2088
+#define EXYNOS4_ARM_CORE2_OPTION				0x2108
+#define EXYNOS4_ARM_CORE3_OPTION				0x2188
+#define EXYNOS4_ARM_COMMON_OPTION				0x2408
+#define EXYNOS4_CAM_OPTION					0x3C08
+#define EXYNOS4_TV_OPTION					0x3C28
+#define EXYNOS4_MFC_OPTION					0x3C48
+#define EXYNOS4_G3D_OPTION					0x3C68
+#define EXYNOS4_LCD0_OPTION					0x3C88
+#define EXYNOS4_ISP_OPTION					0x3CA8
+#define EXYNOS4_MAUDIO_OPTION					0x3CC8
+#define EXYNOS4_GPS_OPTION					0x3CE8
+#define EXYNOS4_GPS_ALIVE_OPTION				0x3D08
+
 /* For EXYNOS5 */
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				0x0408
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
