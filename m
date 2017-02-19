From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 22:41:49 +0100
Subject: [PATCH v5 9/9] ARM64: dts: meson-gx: remove the phy-mode property
 from meson-gx
In-Reply-To: <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170219214149.30418-10-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethmac node has to be configured for each board due to different
pinctrl nodes for RGMII/RMII. Thus the phy-mode should be specified at
the same place (= in the board .dts), making it easier to read the board
.dts file (because the phy-mode is stated explicitly, without requiring
developers to read all "parent" .dtsi as well).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 5d995f7724af..d544b8f2ffbf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -410,7 +410,6 @@
 			       0x0 0xc8834540 0x0 0x4>;
 			interrupts = <0 8 1>;
 			interrupt-names = "macirq";
-			phy-mode = "rgmii";
 			status = "disabled";
 		};
 
-- 
2.11.1
