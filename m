From: dianders@chromium.org (Doug Anderson)
Date: Wed,  6 Aug 2014 10:09:41 -0700
Subject: [PATCH v3 1/4] ARM: dts: Add emmc and sdmmc to the rk3288 device tree
In-Reply-To: <1407344984-14176-1-git-send-email-dianders@chromium.org>
References: <1407344984-14176-1-git-send-email-dianders@chromium.org>
Message-ID: <1407344984-14176-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the sdmmc and emmc ports on the rk3288 using the
currently posted driver from Addy at:
  https://patchwork.kernel.org/patch/4653631/

Note:
* This is not baesd on Jaehoon's patch series removing the slot node,
  but it does use new syntax like putting the bus width at the top
  level and using the new cap-mmc-highspeed / cap-sd-highspeed.  A
  future patch will modify this one to remove the slot node.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v3: None
Changes in v2:
- New patchwork link for Addy's patch

 arch/arm/boot/dts/rk3288.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e7cb008..dc98a5b 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -78,6 +78,28 @@
 		clock-frequency = <24000000>;
 	};
 
+	sdmmc: dwmmc at ff0c0000 {
+		compatible = "rockchip,rk3288-dw-mshc";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xff0c0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	emmc: dwmmc at ff0f0000 {
+		compatible = "rockchip,rk3288-dw-mshc";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xff0f0000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	i2c1: i2c at ff140000 {
 		compatible = "rockchip,rk3288-i2c";
 		reg = <0xff140000 0x1000>;
-- 
2.0.0.526.g5318336
