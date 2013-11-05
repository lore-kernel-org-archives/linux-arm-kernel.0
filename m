From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:10 -0300
Subject: [PATCH v3 03/28] ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370/XP SoCs have a 2 GHz fixed PLL that is used to feed
other clocks. This commit adds a DT representation of this clock
through a fixed-clock compatible node.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 1de2dae..924c721 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -252,4 +252,13 @@
 
 		};
 	};
+
+	clocks {
+		/* 2 GHz fixed main PLL */
+		mainpll: mainpll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <2000000000>;
+		};
+	};
  };
-- 
1.8.1.5
