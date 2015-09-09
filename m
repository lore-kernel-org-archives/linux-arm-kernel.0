From: dongsheng.wang@freescale.com (Dongsheng Wang)
Date: Wed, 9 Sep 2015 14:42:47 +0800
Subject: [PATCH 2/2] arm/layerscape: add RCPM device tree support for ls1021a.
In-Reply-To: <1441780967-30879-1-git-send-email-dongsheng.wang@freescale.com>
References: <1441780967-30879-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <1441780967-30879-2-git-send-email-dongsheng.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 973a496..deb1271 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -139,6 +139,7 @@
 			sdhci,auto-cmd12;
 			big-endian;
 			bus-width = <4>;
+			rcpm-wakeup = <&rcpm 0x00000080 0x0>;
 			status = "disabled";
 		};
 
@@ -186,6 +187,11 @@
 			};
 		};
 
+		rcpm: rcpm at 1ee2000 {
+			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1";
+			reg = <0x0 0x1ee2000 0x0 0x10000>;
+		};
+
 		dspi0: dspi at 2100000 {
 			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
@@ -287,6 +293,7 @@
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sysclk>;
 			clock-names = "ipg";
+			rcpm-wakeup = <&rcpm 0x0 0x40000000>;
 			status = "disabled";
 		};
 
-- 
2.1.0.27.g96db324
