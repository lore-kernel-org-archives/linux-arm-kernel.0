Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E12C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:07:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540C320882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXCV7lQU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KItaiU4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540C320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pxQShihN/hOSfib3+9cqsD/BP+RoIe/qM8UaUVP/nq4=; b=SXCV7lQUb/pZtM
	ekhAG+3LWbqO8C8MtqLPQGGTXK8zm5gtVc8iGV44mhq7fkas/6yUT92WGd5r0HW9n7LMp/wyZfuyt
	PMiZsUKZ8u3aEhK3Rpx0bg1DfEc8Jh4WB/O4XKxaCocaUHC6EIrvXxEzLFzu57h7MCphzq5qYz5a2
	dY+q+PH0SbHmboLn23xef96UjLSRew1XOKJcpVnSWJJWRkzAj+D0biezRvkhxmKYdOH3WOxJHN/RV
	dBc0HeY6UHPhYxOBTEpSzGRTCr161mbGO2fn0oXTWGUEE43bXMu8SyDJw4Tyx2h+vmxeOu+6IqpVx
	oD9t0Au6B/DFPo2DKicw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goniO-0003ku-Bm; Wed, 30 Jan 2019 11:07:32 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonfm-0000aL-09
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:04:57 +0000
Received: by mail-wr1-x441.google.com with SMTP id t6so25511601wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1JcYrtZvqszw/iSfFkQPBLaB9WUxnesJNxpeizJa6Cw=;
 b=KItaiU4hSJibVPtR6hmJtXm4m9a5vk4mk8oH54rd82kxbnJQv2DPi19xqOly61qXm0
 v0XQuD9Pq8Pb0lH9q8SpZlWd4cNUgT/CZbWOVuUFWTa6fWL1M78Umi+z3wxIRV6gt47J
 TNwS4KV8ttV8uI9QrMMScxRifetMgceIdxrLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1JcYrtZvqszw/iSfFkQPBLaB9WUxnesJNxpeizJa6Cw=;
 b=djcNGtVJedKVcHK9nfwC8m7dsxC3gUxZ/haLlhyq9Dp2YPnWnWJnlKocd8JiEVfe9j
 EpTPmnLgEYN0PvYK9pP6kahWCKNpljvXB0Q3Ayfd+1DuFxev0/KPgmNm2+xW3hUDPUWL
 +p3cxF2wloyTp3o9IH1oHft6kqGwHfgeCMDgEatp9g5mndlkaiUq1a6prA8jsAZa5c1f
 EF1iAEZKeBMRmtCtQUvUCD8dTRkYyQEXXJkHqorbT9C2wJpXyyYJx2k9FrQighxGe8VX
 bMRiFZcaSUSdtFUU+ODOOaZ1tUfql6jeTGAJdXlEAumW9yh8EXE8lU9eCuPWgSONS1Jd
 3fqg==
X-Gm-Message-State: AJcUukes6+SV/JNm5HYip7Vfl5iO/moR6atGLrQVpOCzsICLG21gHaUK
 5sqW067pRoobAblKlGlht+UbDTzHKwQ=
X-Google-Smtp-Source: ALg8bN7Y8pbOM3VckgjQTyKwuhbkHAZ2F3g2yLkDNsW/MtOE/qV/FnH9/iCVVlJmQ8Tgbi/R5UgHeA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr29545701wrn.89.1548846288446; 
 Wed, 30 Jan 2019 03:04:48 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:47 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 6/6] arm64: dts: db820c: Add sound card support
Date: Wed, 30 Jan 2019 11:04:37 +0000
Message-Id: <20190130110437.5424-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
References: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030450_393404_A2C78FEB 
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
Cc: linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support both digital and analog audio on DB820c.
This board has HDMI port and 3.5mm audio jack to support both digital
and analog audio respectively.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../dts/qcom/apq8096-db820c-pmic-pins.dtsi    |   8 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi  |  94 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi    |  43 ++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 140 ++++++++++++++++++
 4 files changed, 285 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
index a6ad3d7fe655..31a3e3311ad5 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
@@ -36,6 +36,14 @@
 		};
 	};
 
+	audio_mclk: clk_div1 {
+		pinconf {
+			pins = "gpio15";
+			function = "func1";
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+
 	volume_up_gpio: pm8996_gpio2 {
 		pinconf {
 			pins = "gpio2";
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 1e78f0b47c89..7f4a8a08a029 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -18,6 +18,8 @@
 #include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
@@ -63,6 +65,7 @@
 	};
 
 	clocks {
+		compatible = "simple-bus";
 		divclk4: divclk4 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -72,6 +75,15 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&divclk4_pin_a>;
 		};
+
+		div1_mclk: divclk1 {
+			compatible = "gpio-gate-clock";
+			pinctrl-0 = <&audio_mclk>;
+			pinctrl-names = "default";
+			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+			#clock-cells = <0>;
+			enable-gpios = <&pm8994_gpios 15 0>;
+		};
 	};
 
 	soc {
@@ -453,6 +465,16 @@
 			};
 		};
 
+		slim_msm: slim@91c0000 {
+			ngd@1 {
+				wcd9335: codec@1{
+					clock-names = "mclk", "slimbus";
+					clocks = <&div1_mclk>,
+						 <&rpmcc RPM_SMD_BB_CLK1>;
+				};
+			};
+		};
+
 		mdss@900000 {
 			status = "okay";
 
@@ -666,3 +688,75 @@
 		};
 	};
 };
+
+&sound {
+	compatible = "qcom,apq8096-sndcard";
+	model = "DB820c";
+	audio-routing =	"RX_BIAS", "MCLK";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI";
+		cpu {
+			sound-dai = <&q6afedai HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_6_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9335 6>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9335 1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 131878db9852..fba2229b6236 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -13,6 +13,49 @@
 
 &msmgpio {
 
+	wcd9xxx_intr {
+		wcd_intr_default: wcd_intr_default{
+			mux {
+				pins = "gpio54";
+				function = "gpio";
+			};
+
+			config {
+				pins = "gpio54";
+				drive-strength = <2>; /* 2 mA */
+				bias-pull-down; /* pull down */
+				input-enable;
+			};
+		};
+	};
+
+	cdc_reset_ctrl {
+		cdc_reset_sleep: cdc_reset_sleep {
+			mux {
+				pins = "gpio64";
+				function = "gpio";
+			};
+			config {
+				pins = "gpio64";
+				drive-strength = <16>;
+				bias-disable;
+				output-low;
+			};
+		};
+		cdc_reset_active:cdc_reset_active {
+			mux {
+				pins = "gpio64";
+				function = "gpio";
+			};
+			config {
+				pins = "gpio64";
+				drive-strength = <16>;
+				bias-pull-down;
+				output-high;
+			};
+		};
+	};
+
 	blsp1_spi0_default: blsp1_spi0_default {
 		pinmux {
 			function = "blsp_spi1";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 095041589954..79fa666a4522 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8996.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/soc/qcom,apr.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -1183,6 +1184,33 @@
 			power-domains = <&mmcc MDSS_GDSC>;
 		};
 
+		lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x1600000 0x20000>;
+			#iommu-cells = <1>;
+			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
+			clock-names = "iface", "bus";
+                        status = "okay";
+		};
+
 		agnoc@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
@@ -1349,6 +1377,66 @@
 			};
 		};
 
+		slimbam:dma@9184000
+		{
+			compatible = "qcom,bam-v1.7.0";
+			qcom,controlled-remotely;
+			reg = <0x9184000 0x32000>;
+			num-channels  = <31>;
+			interrupts = <0 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+		};
+
+		slim_msm: slim@91c0000 {
+			compatible = "qcom,slim-ngd-v1.5.0";
+			reg = <0x91c0000 0x2C000>;
+			reg-names = "ctrl";
+			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =	<&slimbam 3>, <&slimbam 4>,
+				<&slimbam 5>, <&slimbam 6>;
+			dma-names = "rx", "tx", "tx2", "rx2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ngd@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				tasha_ifd: tas-ifd {
+					compatible = "slim217,1a0";
+					reg  = <0 0>;
+				};
+
+				wcd9335: codec@1{
+					pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
+					pinctrl-names = "default";
+
+					compatible = "slim217,1a0";
+					reg  = <1 0>;
+
+					interrupt-parent = <&msmgpio>;
+					interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+						     <53 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names  = "intr1", "intr2";
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					reset-gpios = <&msmgpio 64 0>;
+
+					slim-ifc-dev  = <&tasha_ifd>;
+
+					vdd-buck-supply = <&pm8994_s4>;
+					vdd-buck-sido-supply = <&pm8994_s4>;
+					vdd-tx-supply = <&pm8994_s4>;
+					vdd-rx-supply = <&pm8994_s4>;
+					vdd-io-supply = <&pm8994_s4>;
+
+					#sound-dai-cells = <1>;
+				};
+			};
+		};
+
 		gpu@b00000 {
 			compatible = "qcom,adreno-530.2", "qcom,adreno";
 			#stream-id-cells = <16>;
@@ -1507,6 +1595,7 @@
 
 				phys = <&hdmi_phy>;
 				phy-names = "hdmi_phy";
+				#sound-dai-cells = <1>;
 
 				ports {
 					#address-cells = <1>;
@@ -1545,6 +1634,9 @@
 		};
 	};
 
+	sound: sound {
+	};
+
 	adsp-pil {
 		compatible = "qcom,msm8996-adsp-pil";
 
@@ -1571,6 +1663,54 @@
 			mboxes = <&apcs_glb 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			apr {
+				power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+				compatible = "qcom,apr-v2";
+				qcom,smd-channels = "apr_audio_svc";
+				reg = <APR_DOMAIN_ADSP>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				q6core {
+					reg = <APR_SVC_ADSP_CORE>;
+					compatible = "qcom,q6core";
+				};
+
+				q6afe: q6afe {
+					compatible = "qcom,q6afe";
+					reg = <APR_SVC_AFE>;
+					q6afedai: dais {
+						compatible = "qcom,q6afe-dais";
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#sound-dai-cells = <1>;
+						hdmi@1 {
+							reg = <1>;
+						};
+					};
+				};
+
+				q6asm: q6asm {
+					compatible = "qcom,q6asm";
+					reg = <APR_SVC_ASM>;
+					q6asmdai: dais {
+						compatible = "qcom,q6asm-dais";
+						#sound-dai-cells = <1>;
+						iommus = <&lpass_q6_smmu 1>;
+					};
+				};
+
+				q6adm: q6adm {
+					compatible = "qcom,q6adm";
+					reg = <APR_SVC_ADM>;
+					q6routing: routing {
+						compatible = "qcom,q6adm-routing";
+						#sound-dai-cells = <0>;
+					};
+				};
+			};
 		};
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
