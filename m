From: leilk.liu@mediatek.com (leilk.liu at mediatek.com)
Date: Fri, 8 May 2015 16:55:43 +0800
Subject: [PATCH 3/3] arm64: dts: Add spi bus dts
In-Reply-To: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1431075343-7887-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilk Liu <leilk.liu@mediatek.com>

This patch adds MT8173 spi bus controllers into device tree.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3fca624..4ff7c24 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -258,6 +258,15 @@
 			clock-names = "baud", "bus";
 			status = "disabled";
 		};
+
+		spi: spi at 1100a000 {
+			compatible = "mediatek,mt8173-spi";
+			reg = <0 0x1100a000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_SPI0>;
+			clock-names = "main";
+			status = "disabled";
+		};
 	};
 
 };
-- 
1.8.1.1.dirty
