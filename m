From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 20 Aug 2014 21:09:24 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add saradc nodes
In-Reply-To: <2306550.nl6CA81PdX@phil>
References: <2306550.nl6CA81PdX@phil>
Message-ID: <2291940.YGoWa0tBhA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the core device nodes for the SARADC found on both the Cortex-A9 series
(rk3066 and rk3188) as well as the newer rk3288.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
if nobody complains I'll queue this into my v3.18-next/dts branch

 arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 36be7bb..431f384 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -98,6 +98,16 @@
 		status = "disabled";
 	};
 
+	saradc: saradc at ff100000 {
+		compatible = "rockchip,saradc";
+		reg = <0xff100000 0x100>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		#io-channel-cells = <1>;
+		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		status = "disabled";
+	};
+
 	i2c1: i2c at ff140000 {
 		compatible = "rockchip,rk3288-i2c";
 		reg = <0xff140000 0x1000>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 8caf85d..cce4a07 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -264,4 +264,14 @@
 		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 		status = "disabled";
 	};
+
+	saradc: saradc at 2006c000 {
+		compatible = "rockchip,saradc";
+		reg = <0x2006c000 0x100>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		#io-channel-cells = <1>;
+		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		status = "disabled";
+	};
 };
-- 
1.9.0
