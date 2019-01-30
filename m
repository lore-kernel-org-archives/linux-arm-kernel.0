Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C25C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162872184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VwyRUeov";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wz4S6W6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162872184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FSl1eKpttRBLT2fvPmyUo4wLS83aCeblMPH3OCfYqew=; b=VwyRUeovPhE/ev
	iLAJ6mI88g2zERAFvQNhb5XHSVXsCIH2k/zPC+GtJ3/NIHKjQKUpns00q5ORBxvBYFiuuM/x4sf1q
	nj2QnH3oJLFR0HK74EKd5WFoTE2eekzljx0vm1ZAIgzpkfVZ9VchY/aZ6I4hD8Kj1NYR+WILKpoBa
	0t9OrS1oL7mFwvQt5uv1+iSoULINsLcuuRoboOvZFyujNAGAjs9qRQr4l1ClwXnyk4ETuvBMXEcL/
	yCKP+q81DBQx018j3K+EFufxwJLurqi82zBqZqU1/nvVigFmV4FaOH3NycExjPi2+sglwr5/CYA/7
	E0ByzIwaiRpOdsCCEfJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowIk-0000ud-Mb; Wed, 30 Jan 2019 20:17:38 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowIg-0000uE-4O
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 20:17:36 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so193670wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rcmBiNckGBL8JgpePhychms4DP2WGCi+OpJzN+vu+EQ=;
 b=wz4S6W6Ypwwf/BkuuB39TKUdqnk0sNrblBwiC+okge6YJ2klBvyG08bIwhgus7IKbQ
 dZD+4PrlYFZtIQTjO1vcOrkA/TcCwC6AacXL2MyDTIpPtB9VcctvAhV/sv8p2lcgqr+3
 Y0aZaZUzvaRvC2QUa4SdnFfNta3+dS9tFJ+AVMoPlMpXIeeCmzsXSQlPPfqBjqIqgo6V
 zE+qavcSZEi+VuSRQR33wUaGqbToc62p1xQaUPb2sSr3IAx95EnOiXSfYw1kkD5mDlJZ
 nig8dKmCDjFMTGnnFdBThQWEQ5BH0ACmxoOAzfKIk4Zjmone/tk2iJiJqNIDDtMo5Ra1
 7PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rcmBiNckGBL8JgpePhychms4DP2WGCi+OpJzN+vu+EQ=;
 b=Ou0CaRYMcqr9B3rdL1ecHB+xLslSQXU0urFrSXd7u4jpmln2HbQSpLRF/opWxYiSdI
 I5nIcSoMGbgDeVHjT06rPf01YT7Jn6WBcGCaJX9EyU2VMZQvXTTGu7kXC0dxjT6QqA++
 5mnnDXqWRYqCeV+8B0v9E5zbuWqxkRgWNfnCk5OxGW/DQFLOtWJmfg+eW69o4WM8Dpxw
 SXienb3FqtNRjiN5u7rYYytDcaAOBe6/QR6xSfJaz6IioJTBWQ570TL5Du3ZNURY8bA2
 4o3EsPGZ05L2GUAoxr2DmUqdR6wLz8vUA5OM6Eu2aTgjZeXQQ30JMXU00Iga0Pj3kjek
 qcuA==
X-Gm-Message-State: AJcUuke+OxdxbTX+86P31s3dHYp4+aS4prcjsUINDasvVmVu4TKCP1Wn
 8vJOnzm9d3lIasd132QlCKXMnA==
X-Google-Smtp-Source: ALg8bN7veqAZAdiqOfxs55xokh+L/FYIQ/coXDY4PjnZwA9SbDBVdTdJkGdTIKTMpYQKe78XIu2Wpw==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr27789670wmh.74.1548879451677;
 Wed, 30 Jan 2019 12:17:31 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id b12sm1438016wmj.3.2019.01.30.12.17.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 12:17:30 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: imx8mq: Add missing M4 clocks
Date: Wed, 30 Jan 2019 20:17:25 +0000
Message-Id: <20190130201725.18961-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_121734_235517_4C23D6A5 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The clocks list is missing the clocks for the the M4 core.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/clk/imx/clk-imx8mq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 398ab0bcd9de..c02c43fcb892 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -48,6 +48,9 @@ static const char * const dram_pll2_out_sels[] = {"dram_pll2_div", "dram_pll1_re
 static const char * const imx8mq_a53_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
 					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll2_out", };
 
+static const char * const imx8mq_arm_m4_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_250m", "sys1_pll_266m",
+					"sys1_pll_800m", "audio_pll1_out", "video_pll1_out", "sys3_pll2_out", };
+
 static const char * const imx8mq_vpu_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
 					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "vpu_pll_out", };
 
@@ -396,15 +399,19 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	/* CORE */
 	clks[IMX8MQ_CLK_A53_SRC] = imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
+	clks[IMX8MQ_CLK_M4_SRC] = imx_clk_mux2("arm_m4_src", base + 0x8080, 24, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));
 	clks[IMX8MQ_CLK_VPU_SRC] = imx_clk_mux2("vpu_src", base + 0x8100, 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
 	clks[IMX8MQ_CLK_GPU_CORE_SRC] = imx_clk_mux2("gpu_core_src", base + 0x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
 	clks[IMX8MQ_CLK_GPU_SHADER_SRC] = imx_clk_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));
+
 	clks[IMX8MQ_CLK_A53_CG] = imx_clk_gate3_flags("arm_a53_cg", "arm_a53_src", base + 0x8000, 28, CLK_IS_CRITICAL);
+	clks[IMX8MQ_CLK_M4_CG] = imx_clk_gate3("arm_m4_cg", "arm_m4_src", base + 0x8080, 28);
 	clks[IMX8MQ_CLK_VPU_CG] = imx_clk_gate3("vpu_cg", "vpu_src", base + 0x8100, 28);
 	clks[IMX8MQ_CLK_GPU_CORE_CG] = imx_clk_gate3("gpu_core_cg", "gpu_core_src", base + 0x8180, 28);
 	clks[IMX8MQ_CLK_GPU_SHADER_CG] = imx_clk_gate3("gpu_shader_cg", "gpu_shader_src", base + 0x8200, 28);
 
 	clks[IMX8MQ_CLK_A53_DIV] = imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
+	clks[IMX8MQ_CLK_M4_DIV] = imx_clk_divider2("arm_m4_div", "arm_m4_cg", base + 0x8080, 0, 3);
 	clks[IMX8MQ_CLK_VPU_DIV] = imx_clk_divider2("vpu_div", "vpu_cg", base + 0x8100, 0, 3);
 	clks[IMX8MQ_CLK_GPU_CORE_DIV] = imx_clk_divider2("gpu_core_div", "gpu_core_cg", base + 0x8180, 0, 3);
 	clks[IMX8MQ_CLK_GPU_SHADER_DIV] = imx_clk_divider2("gpu_shader_div", "gpu_shader_cg", base + 0x8200, 0, 3);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
