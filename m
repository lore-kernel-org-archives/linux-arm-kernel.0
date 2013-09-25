From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 25 Sep 2013 18:28:20 -0300
Subject: [PATCH 3/5] ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
In-Reply-To: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1380144502-24109-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370/XP SoCs have a 2 GHz fixed PLL that is used to feed
other clocks. This commit adds a DT representation of this clock
through a fixed-clock compatible node.

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
