From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Feb 2015 13:39:20 +0100
Subject: [PATCH v3 5/5] ARM: dts: pxa: add pxa-timer to pxa27x
In-Reply-To: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
References: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423312760-15871-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa has an embedded OS Timers IP. The kernel cannot work without a
valid clocksource, and this adds the OS Timers to the pxa device-tree
description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: removed clocksource node, pxa-timer being directly under
          pxabus (Rob's comment).
Since v2: renamed pxa-timer to timer (Sergei's comment)
---
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 6ecf1a6..fb0abad 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -101,4 +101,12 @@
 			status = "okay";
 		};
 	};
+
+	timer at 40a00000 {
+		compatible = "marvell,pxa-timer";
+		reg = <0x40a00000 0x20>;
+		interrupts = <26>;
+		clocks = <&pxa2xx_clks CLK_OSTIMER>;
+		status = "okay";
+	};
 };
-- 
2.1.0
