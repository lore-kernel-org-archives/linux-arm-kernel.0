From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 2 Sep 2013 19:52:20 +0530
Subject: [PATCH RFC 6/6] ARM: dts: AM4372: prcm node (for reset)
In-Reply-To: <cover.1378129416.git.afzal@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
Message-ID: <3ed48b0a5057a3efee97f4d91bd54214312a5adb.1378129416.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AM4372 prcm node with reset binding.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 5a68fde..d0d11b3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -411,6 +411,12 @@
 			ti,hwmods = "epwmss5";
 			status = "disabled";
 		};
+
+		prcm: prcm at 44df0000 {
+			compatible = "ti,am4372-prcm";
+			reg = <0x44df0000 0xa000>;
+			#reset-cells = <1>;
+		};
 	};
 
 	clocks {
-- 
1.8.3.4
