From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 14 Oct 2015 11:23:35 +0800
Subject: [PATCH 5/5] arm64: dts: spi bus dts support multiple devices
In-Reply-To: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
References: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1444793015-30359-6-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch support multiple devices for MT8173.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 04b38ed..1c8c407 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -194,7 +194,7 @@
 			pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
 				<MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
 				<MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
-				<MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
+				<MT8173_PIN_72_SPI_CS__FUNC_GPIO72>;
 		};
 	};
 };
@@ -399,6 +399,7 @@
 &spi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_pins_a>;
+	cs-gpios = <&pio 72 0>;
 	mediatek,pad-select = <0>;
 	status = "okay";
 };
-- 
1.8.1.1.dirty
