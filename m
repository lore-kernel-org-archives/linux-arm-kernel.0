From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 25 Sep 2013 18:28:22 -0300
Subject: [PATCH 5/5] ARM: mvebu: Add NAND clock to Armada 370/XP
In-Reply-To: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1380144502-24109-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the NAND clock available at Armada 370/XP SoC, which is a
fixed-factor derived from the NAND ECC clock. This is the clock
feeding the NAND controller.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index d0f81cc..8f14092 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -268,5 +268,13 @@
 			#clock-cells = <0>;
 			clock-frequency = <2000000000>;
 		};
+
+		ndclk: nand_clock {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&coredivclk 0>;
+	                clock-div = <2>;
+	                clock-mult = <1>;
+		};
 	};
  };
-- 
1.8.1.5
