From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 24 Jan 2014 13:49:47 +0100
Subject: [PATCH v2 11/15] ARM: shmobile: r8a7791 dtsi: Add QSPI node
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1390567791-8988-12-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree at vger.kernel.org
---
v2:
  - No changes

 arch/arm/boot/dts/r8a7791.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d5cc3626dd60..240c4ece1f0c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -710,4 +710,16 @@
 			clock-output-names = "scifa3", "scifa4", "scifa5";
 		};
 	};
+
+	spi: spi at e6b10000 {
+		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
+		reg = <0 0xe6b10000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5
