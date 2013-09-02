From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 2 Sep 2013 19:52:04 +0530
Subject: [PATCH RFC 5/6] ARM: dts: AM335x: prcm node (for reset)
In-Reply-To: <cover.1378129416.git.afzal@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
Message-ID: <00675d65eef61eb4222e6a461ef479ebbd1d4787.1378129416.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AM335x prcm node with reset binding.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4701e3c..c2ccf94 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -530,6 +530,12 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		prcm: prcm at 44e00000 {
+			compatible = "ti,am3352-prcm";
+			reg = <0x44e00000 0x1300>;
+			#reset-cells = <1>;
+		};
 	};
 
 	clocks {
-- 
1.8.3.4
