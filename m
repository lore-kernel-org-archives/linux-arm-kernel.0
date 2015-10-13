From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Tue, 13 Oct 2015 17:39:20 +0800
Subject: [PATCH v4 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <1444729160-26433-4-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mediatek nor flash node

Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..385c2e4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -365,6 +365,21 @@
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
+
+			flash at 0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+			};
+		};
+
 		i2c3: i2c3 at 11010000 {
 			compatible = "mediatek,mt8173-i2c";
 			reg = <0 0x11010000 0 0x70>,
-- 
1.8.1.1.dirty
