From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 Apr 2018 13:25:18 +0900
Subject: [PATCH] arm64: dts: uniphier: stabilize ethernet of LD20 reference
 boar
Message-ID: <1524803118-32570-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the ethernet RGMII mode on the LD20 reference board is
unstable.

The default drive-strength of ethernet TX pins is too strong because
there is no dumping resistor on the TX lines on the board.

Weaken the drive-strength to make the ethernet more stable.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 2c1a92f..440c2e6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -67,3 +67,11 @@
 		reg = <0>;
 	};
 };
+
+&pinctrl_ether_rgmii {
+	tx {
+		pins = "RGMII_TXCLK", "RGMII_TXD0", "RGMII_TXD1",
+		       "RGMII_TXD2", "RGMII_TXD3", "RGMII_TXCTL";
+		drive-strength = <9>;
+	};
+};
-- 
2.7.4
