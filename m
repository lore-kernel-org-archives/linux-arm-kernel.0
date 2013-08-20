From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 09:36:26 -0300
Subject: [PATCH v2 1/4] ARM: mvebu: Add the reference 25 MHz fixed-clock to
 Armada XP
In-Reply-To: <1377002189-4398-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377002189-4398-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377002189-4398-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP SoC has a reference 25 MHz fixed-clock that is used in
some controllers such as the timer and the watchdog. This commit adds
a DT representation of this clock through a fixed-clock compatible node.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 549151e..50e404e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -162,4 +162,13 @@
 			};
 		};
 	};
+
+	clocks {
+		/* 25 MHz reference crystal */
+		refclk: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+	};
 };
-- 
1.8.1.5
