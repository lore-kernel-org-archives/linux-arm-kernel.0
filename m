From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Feb 2015 18:22:38 +0100
Subject: [PATCH v4 5/5] ARM: dts: pxa: add pxa-timer to pxa27x and pxa3xx
In-Reply-To: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
References: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423761758-29159-5-git-send-email-robert.jarzmik@free.fr>
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
Since v3: added pxa-timer to pxa3xx as well
---
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
 arch/arm/boot/dts/pxa3xx.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 74f7df7..90b9971 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -85,4 +85,12 @@
 			status = "okay";
 		};
 	};
+
+	timer at 40a00000 {
+		compatible = "marvell,pxa-timer";
+		reg = <0x40a00000 0x20>;
+		interrupts = <26>;
+		clocks = <&clks CLK_OSTIMER>;
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index c7066eb..7ad0b17 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -59,4 +59,12 @@
 			status = "okay";
 		};
 	};
+
+	timer at 40a00000 {
+		compatible = "marvell,pxa-timer";
+		reg = <0x40a00000 0x20>;
+		interrupts = <26>;
+		clocks = <&clks CLK_OSTIMER>;
+		status = "okay";
+	};
 };
-- 
2.1.0
