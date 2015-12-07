From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Mon, 7 Dec 2015 11:53:14 +0800
Subject: [PATCH] arm64: dts: mt8173: Add nor flash node
Message-ID: <1449460394-31601-1-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mediatek nor flash node

Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
Previous version of this patch is
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386005.html
Drop flash node from mt8173.dtsi accroding review comment

---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 4dd5f93..af08e97 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -387,6 +387,17 @@
 			status = "disabled";
 		};
 
+		nor_flash: spi at 1100d000 {
+			compatible = "mediatek,mt8173-nor";
+			reg = <0 0x1100d000 0 0xe0>;
+			clocks = <&pericfg CLK_PERI_SPI>,
+				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+			clock-names = "spi", "sf";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		i2c3: i2c at 11010000 {
 			compatible = "mediatek,mt8173-i2c";
 			reg = <0 0x11010000 0 0x70>,
-- 
1.8.1.1.dirty
