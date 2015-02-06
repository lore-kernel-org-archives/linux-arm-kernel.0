From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri,  6 Feb 2015 23:48:17 +0100
Subject: [PATCH v2 5/5] ARM: dts: pxa: add pxa-timer to pxa27x
In-Reply-To: <1423262897-24044-1-git-send-email-robert.jarzmik@free.fr>
References: <1423262897-24044-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423262897-24044-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa has an embedded OS Timers IP. The kernel cannot work without a
valid clocksource, and this adds the OS Timers to the pxa device-tree
description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: removed clocksource node, pxa-timer being directly under
          pxabus (Rob's comment).
---
 arch/arm/boot/dts/pxa27x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 7f93828..473f9d8 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -97,5 +97,12 @@
 			status = "okay";
 		};
 	};
+
+	pxa-timer at 40a00000 {
+		compatible = "marvell,pxa-timer";
+		reg = <0x40a00000 0x20>;
+		interrupts = <26>;
+		clocks = <&pxa2xx_clks CLK_OSTIMER>;
+		status = "okay";
 	};
 };
-- 
2.1.0
