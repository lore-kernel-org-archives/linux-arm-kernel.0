Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FFC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFA22086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xu2LZKQX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BElyAT2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFA22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7W7kQvrABYJrwW0217spTJ4c54Lmc1QTi0eBesQ9V20=; b=Xu2LZKQXw5Tvbu
	6Vpto8sEkNojJflcOspeRTszcLRWuqHQUS5xa7TOkUM7FIda364mb9ZBtKZTh35PTeyNmEUXHciyv
	poVX7zi6UYI4pPGpLLxEsY9mGWnFjyx/hkbHPOQmSvIDqHSboxtUITQvByozvnlBx0hLXX+YyxJvY
	tThC4oK03AAuwBRZFNT30S7rIhMKuAzwKPorWezZiASVZ3k4L7Zbxl6HqW78T50/kS1Ump7M/W+/D
	QR/50UUJUaPk+TYgWqgQ0W7AEgZXQTD7eIDya/c68gVIeZvadUNfKkHkY5tF5bx7fFp+4ovW7vdIw
	NDY/whefiEES/HVTssEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpaDK-0004BN-5Q; Fri, 01 Feb 2019 14:54:42 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpaCb-0003Rc-A0
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:54:01 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so7340684wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jtJIhb/AIChsXRzDEqEZ3Q/1glXaawkRJNjvKGqTd+c=;
 b=BElyAT2t6800H7zFAI3p5ldT0zY+SsIuEdsaqfNBftrAnrp/mJl9bn/B8br0QuWDNi
 XzCEaGwlHFk8wnBbOf8MPKHZqbM/U2DhLBBAYIR10oSEEG3E/rGeLMzjbL8qYDuiQmxV
 SV5tchP1uhPIhZlSUzZee/+YOXjwTJ3LlMMsJRMe+q1pIphpV/F1raZrw59lJyHNF6em
 /wAPbWNMFP5gcklKuuHfQgOhULadbQGdAaxNMJNOvlFFX1i+kUst2E4A8wht6jdMghBi
 /UYvbARd/8F7w2Z1Ay7Qnr4O2sNjqi/vu7dbCfXJ0VaNwQ7bqY1reim785VTAWZNPwu6
 GjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jtJIhb/AIChsXRzDEqEZ3Q/1glXaawkRJNjvKGqTd+c=;
 b=peMzaX8DMPUy+3GDfiD98gTcxIR2/yYKhFOvf3cTDe1awzQZ+6FFVddl50UZkfRInp
 kJCfE5iy+cLxKzn5DUP74X0saAmIdglxcpWzGDUToT0qVVXefkX0km49SXMSsk2Lp15X
 /9nykcTFx3cRWpCLLcOuXit7uogQ/4mYjLtoS8mtmdOp5vRPMY5xKEuxyVd+RNKdt8vY
 x/4xuGhfP5dxP6jg2zwfJr2bOVFMYSZ40cskzFTp2AjvQ4LX89xHMBBTSp6bHz/gIWfL
 C5UYJE4/4Ji++JL35vjAXDsJDx4SqibhQkuv/Mvm+EaNCnQ5xxk2HkZzNLOtjtlzrS7x
 HmQw==
X-Gm-Message-State: AJcUukdzhXzKjrEAaadn8SOyyRd2pmHGffVk/LYQgvgEj8fBubhvtVeX
 6DYyLW7FnB6+EndkZCF9NC9AEtLrVKU=
X-Google-Smtp-Source: ALg8bN4u/dB2bKleQqFdDPgFi6lSf9YdIP3OpLDpVvBleFmOlGZ0Nptfoeb5+EHctpglKVSwrOEa+g==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr39809870wrv.88.1549032835490; 
 Fri, 01 Feb 2019 06:53:55 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id x186sm4754644wmg.41.2019.02.01.06.53.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 06:53:54 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v6 2/4] dt-bindings: clk: meson: add g12a periph clock
 controller bindings
Date: Fri,  1 Feb 2019 15:53:43 +0100
Message-Id: <20190201145345.6795-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201145345.6795-1-jbrunet@baylibre.com>
References: <20190201145345.6795-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_065357_343167_A8E726AA 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

Add new clock controller compatible and dt-bindings header for the
Everything-Else domain of the g12a SoC

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 include/dt-bindings/clock/g12a-clkc.h         | 135 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index a6871953bf04..5c8b105be4d6 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -9,6 +9,7 @@ Required Properties:
 		"amlogic,gxbb-clkc" for GXBB SoC,
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
+		"amlogic,g12a-clkc" for G12A SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
new file mode 100644
index 000000000000..83b657038d1e
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Meson-G12A clock tree IDs
+ *
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __G12A_CLKC_H
+#define __G12A_CLKC_H
+
+#define CLKID_SYS_PLL				0
+#define CLKID_FIXED_PLL				1
+#define CLKID_FCLK_DIV2				2
+#define CLKID_FCLK_DIV3				3
+#define CLKID_FCLK_DIV4				4
+#define CLKID_FCLK_DIV5				5
+#define CLKID_FCLK_DIV7				6
+#define CLKID_GP0_PLL				7
+#define CLKID_CLK81				10
+#define CLKID_MPLL0				11
+#define CLKID_MPLL1				12
+#define CLKID_MPLL2				13
+#define CLKID_MPLL3				14
+#define CLKID_DDR				15
+#define CLKID_DOS				16
+#define CLKID_AUDIO_LOCKER			17
+#define CLKID_MIPI_DSI_HOST			18
+#define CLKID_ETH_PHY				19
+#define CLKID_ISA				20
+#define CLKID_PL301				21
+#define CLKID_PERIPHS				22
+#define CLKID_SPICC0				23
+#define CLKID_I2C				24
+#define CLKID_SANA				25
+#define CLKID_SD				26
+#define CLKID_RNG0				27
+#define CLKID_UART0				28
+#define CLKID_SPICC1				29
+#define CLKID_HIU_IFACE				30
+#define CLKID_MIPI_DSI_PHY			31
+#define CLKID_ASSIST_MISC			32
+#define CLKID_SD_EMMC_A				33
+#define CLKID_SD_EMMC_B				34
+#define CLKID_SD_EMMC_C				35
+#define CLKID_AUDIO_CODEC			36
+#define CLKID_AUDIO				37
+#define CLKID_ETH				38
+#define CLKID_DEMUX				39
+#define CLKID_AUDIO_IFIFO			40
+#define CLKID_ADC				41
+#define CLKID_UART1				42
+#define CLKID_G2D				43
+#define CLKID_RESET				44
+#define CLKID_PCIE_COMB				45
+#define CLKID_PARSER				46
+#define CLKID_USB				47
+#define CLKID_PCIE_PHY				48
+#define CLKID_AHB_ARB0				49
+#define CLKID_AHB_DATA_BUS			50
+#define CLKID_AHB_CTRL_BUS			51
+#define CLKID_HTX_HDCP22			52
+#define CLKID_HTX_PCLK				53
+#define CLKID_BT656				54
+#define CLKID_USB1_DDR_BRIDGE			55
+#define CLKID_MMC_PCLK				56
+#define CLKID_UART2				57
+#define CLKID_VPU_INTR				58
+#define CLKID_GIC				59
+#define CLKID_SD_EMMC_A_CLK0			60
+#define CLKID_SD_EMMC_B_CLK0			61
+#define CLKID_SD_EMMC_C_CLK0			62
+#define CLKID_HIFI_PLL				74
+#define CLKID_VCLK2_VENCI0			80
+#define CLKID_VCLK2_VENCI1			81
+#define CLKID_VCLK2_VENCP0			82
+#define CLKID_VCLK2_VENCP1			83
+#define CLKID_VCLK2_VENCT0			84
+#define CLKID_VCLK2_VENCT1			85
+#define CLKID_VCLK2_OTHER			86
+#define CLKID_VCLK2_ENCI			87
+#define CLKID_VCLK2_ENCP			88
+#define CLKID_DAC_CLK				89
+#define CLKID_AOCLK				90
+#define CLKID_IEC958				91
+#define CLKID_ENC480P				92
+#define CLKID_RNG1				93
+#define CLKID_VCLK2_ENCT			94
+#define CLKID_VCLK2_ENCL			95
+#define CLKID_VCLK2_VENCLMMC			96
+#define CLKID_VCLK2_VENCL			97
+#define CLKID_VCLK2_OTHER1			98
+#define CLKID_FCLK_DIV2P5			99
+#define CLKID_DMA				105
+#define CLKID_EFUSE				106
+#define CLKID_ROM_BOOT				107
+#define CLKID_RESET_SEC				108
+#define CLKID_SEC_AHB_APB3			109
+#define CLKID_VPU_0_SEL				110
+#define CLKID_VPU_0				112
+#define CLKID_VPU_1_SEL				113
+#define CLKID_VPU_1				115
+#define CLKID_VPU				116
+#define CLKID_VAPB_0_SEL			117
+#define CLKID_VAPB_0				119
+#define CLKID_VAPB_1_SEL			120
+#define CLKID_VAPB_1				122
+#define CLKID_VAPB_SEL				123
+#define CLKID_VAPB				124
+#define CLKID_HDMI_PLL				128
+#define CLKID_VID_PLL				129
+#define CLKID_VCLK				138
+#define CLKID_VCLK2				139
+#define CLKID_VCLK_DIV1				148
+#define CLKID_VCLK_DIV2				149
+#define CLKID_VCLK_DIV4				150
+#define CLKID_VCLK_DIV6				151
+#define CLKID_VCLK_DIV12			152
+#define CLKID_VCLK2_DIV1			153
+#define CLKID_VCLK2_DIV2			154
+#define CLKID_VCLK2_DIV4			155
+#define CLKID_VCLK2_DIV6			156
+#define CLKID_VCLK2_DIV12			157
+#define CLKID_CTS_ENCI				162
+#define CLKID_CTS_ENCP				163
+#define CLKID_CTS_VDAC				164
+#define CLKID_HDMI_TX				165
+#define CLKID_HDMI				168
+#define CLKID_MALI_0_SEL			169
+#define CLKID_MALI_0				171
+#define CLKID_MALI_1_SEL			172
+#define CLKID_MALI_1				174
+#define CLKID_MALI				175
+#define CLKID_MPLL_5OM				177
+
+#endif /* __G12A_CLKC_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
