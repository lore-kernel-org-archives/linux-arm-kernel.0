From: dianders@chromium.org (Doug Anderson)
Date: Tue, 12 Aug 2014 16:21:13 -0700
Subject: [PATCH v4 1/2] ARM: dts: Add emmc and sdmmc to the rk3288 device tree
In-Reply-To: <1407885674-16469-1-git-send-email-dianders@chromium.org>
References: <1407885674-16469-1-git-send-email-dianders@chromium.org>
Message-ID: <1407885674-16469-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the sdmmc and emmc ports on the rk3288.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v4:
- Add status="disabled".
- Squash patch #1 and #4 since Jaehoon's patch landed.

Changes in v3: None
Changes in v2:
- Refer to the new title of Jaehoon's patch
- New patchwork link for Addy's patch

 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..36be7bb 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -78,6 +78,26 @@
 		clock-frequency = <24000000>;
 	};
 
+	sdmmc: dwmmc at ff0c0000 {
+		compatible = "rockchip,rk3288-dw-mshc";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xff0c0000 0x4000>;
+		status = "disabled";
+	};
+
+	emmc: dwmmc at ff0f0000 {
+		compatible = "rockchip,rk3288-dw-mshc";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xff0f0000 0x4000>;
+		status = "disabled";
+	};
+
 	i2c1: i2c at ff140000 {
 		compatible = "rockchip,rk3288-i2c";
 		reg = <0xff140000 0x1000>;
-- 
2.1.0.rc2.206.gedb03e5
