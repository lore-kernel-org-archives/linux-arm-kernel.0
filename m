Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F74EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCA42184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M14/+J9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCA42184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v5WUo4XobPDaqw0intGmo49rPoJ6K26AFxgqGg6yNuY=; b=M14/+J9X2m5WIw
	lgDylOwojZGbpy/N41b7IejUz4uWjEyepp9vFc11JNJ4ojrFrdFYXRhishGjsQ893g0CjbSpOnhSw
	ewFIkg0Ok6TwBZ6Txs+yzds467W8BJvl0ryeKrc/Ke5lNS8I9yaqa1BcYGH5MTOI2mnyCPNYihaQj
	eoWV/+bNbLbLko6B9oncsjoWU7RZWqKavwadmxrc9kdCqJU30ssPxAsc10epeH97i4D4ZJiOqp6k9
	7n0urXUi3tn5vyELKbjIG5lar2ZrstGqNg1o9M0g+cIX+vUfVRmHkWEihUbxmO+/SQPoBVAAvAXvx
	5e/h6oy8ZRcUTBiVoE4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfEUS-00030H-Iu; Fri, 04 Jan 2019 01:41:36 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfEU2-0002XI-Cn; Fri, 04 Jan 2019 01:41:27 +0000
Received: by mail-qk1-f195.google.com with SMTP id 68so20758955qke.9;
 Thu, 03 Jan 2019 17:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=ZGFhud/si8vg/N36E17BPr7LYDjCfXkDc52GiIyxOko=;
 b=Fidsp+NolpATnuBBpx9FCjUj07SpV3xNVTFsApOAxSl9V7xBgjWo89/CR2SarKH3zs
 U39KqD59ozFK9WLKZd09z+ycHrs/h4CLeOMaYBf1gq/dnE8Am3+/zTeOako29EkkQGPZ
 gZYMfaqqCR4V6N4vj/8tysgCyzAKKokDIiuQo36TL74LJXBhAFhdkwvAqE4XU3ww6MaC
 ccQpnqK70kjIo+8JcZxmOGnNuJDsOUgnKiVzID7+73/YZE7TsoHrfo4qOxHuSW9Qej8i
 A2kkSO7ovgrKQ1Vcz1AviA2gCZ/ox1m3GboS+1p9i22hpZ4fgNuBXXNLMp8MIO6iH8qf
 0z0w==
X-Gm-Message-State: AJcUukf1tEvf1yzNRkfBCYATifc/cIegNuw53DIpsCf7DilKxazYISoI
 FQEoLhdAzxgLwqZ1Iv+m+8O3pHl3
X-Google-Smtp-Source: ALg8bN6SDKMP6HJ5wVjNXtkle2JXBZF/AED00Zv9yfL3DBKua5DZ98D39igbcZGUM6ZnOC9bFVufAA==
X-Received: by 2002:a37:474b:: with SMTP id u72mr45242329qka.106.1546566069199; 
 Thu, 03 Jan 2019 17:41:09 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
 by smtp.gmail.com with ESMTPSA id g5sm21615704qkd.55.2019.01.03.17.41.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 17:41:08 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 03 Jan 2019 23:41:02 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: rv1108: Add support for rv1108-elgin-r1 board
Date: Thu,  3 Jan 2019 23:40:23 -0200
Message-Id: <20190104014023.17973-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104014023.17973-1-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_174110_840388_A5BA5C4B 
X-CRM114-Status: GOOD (  16.88  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Otavio Salvador <otavio@ossystems.com.br>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Vicent Chi <vicent.chi@rock-chips.com>,
 Olof Johansson <olof@lixom.net>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

rv1108-elgin-r1 board is based on Rockchip RV1108 SoC.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rv1108-elgin-r1.dts         | 206 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 arch/arm/boot/dts/rv1108-elgin-r1.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index b12958bda09c..d30fff4b4676 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -60,6 +60,11 @@ properties:
           - const: chipspark,rayeager-px2
           - const: rockchip,rk3066a
 
+      - description: Elgin RV1108 R1
+        items:
+          - const: elgin,rv1108-r1
+          - const: rockchip,rv1108
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 78551c4375d5..9e31d4b94320 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -865,6 +865,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
+	rv1108-elgin-r1.dtb \
 	rv1108-evb.dtb \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
new file mode 100644
index 000000000000..7b24558f13e0
--- /dev/null
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/*
+ * Copyright (C) 2018 O.S. Systems Software LTDA.
+ */
+
+/dts-v1/;
+
+#include "rv1108.dtsi"
+
+/ {
+	model = "Elgin RV1108 R1 board";
+	compatible = "elgin,rv1108-r1", "rockchip,rv1108";
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x08000000>;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	vcc_sys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_core>;
+};
+
+&emmc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	no-sd;
+	no-sdio;
+	non-removable;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rmii_pins>;
+	snps,reset-gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	clock_in_out = "output";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <275>;
+	i2c-scl-falling-time-ns = <16>;
+	clock-frequency = <400000>;
+
+	rk805: pmic@18 {
+		compatible = "rockchip,rk805";
+		reg = <0x18>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		rockchip,system-power-controller;
+
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc5-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+
+		regulators {
+			vdd_core: DCDC_REG1 {
+				regulator-name= "vdd_core";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <900000>;
+				};
+			};
+
+			vdd_cam: DCDC_REG2 {
+				regulator-name= "vdd_cam";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name= "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+				};
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-name= "vcc_io";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <3300000>;
+				};
+			};
+
+			vdd_10: LDO_REG1 {
+				regulator-name= "vdd_10";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vcc_18: LDO_REG2 {
+				regulator-name= "vcc_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vdd10_pmu: LDO_REG3 {
+				regulator-name= "vdd10_pmu";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <1000000>;
+				};
+			};
+		};
+	};
+};
+
+&spi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
+	status = "okay";
+
+	dh2228fv: dac@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+		spi-cpha;
+		spi-cpol;
+	};
+};
+
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		status = "okay";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
