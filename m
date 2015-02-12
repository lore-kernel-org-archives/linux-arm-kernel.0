From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Feb 2015 18:22:36 +0100
Subject: [PATCH v4 3/5] ARM: dts: pxa: add pxa27x-udc to pxa27x
In-Reply-To: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
References: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423761758-29159-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa27x has an embedded usb udc controller. Add it in the pxa27x
device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v3: changed pxa2xx-clks into clks
---
 arch/arm/boot/dts/pxa27x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 9696718..7cc36ef 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -53,6 +53,13 @@
 			status = "disabled";
 		};
 
+		pxa27x_udc: udc at 40600000 {
+			compatible = "marvell,pxa270-udc";
+			reg = <0x40600000 0x10000>;
+			interrupts = <11>;
+			clocks = <&clks CLK_USB>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.0
