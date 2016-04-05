From: s-anna@ti.com (Suman Anna)
Date: Tue, 5 Apr 2016 16:44:10 -0500
Subject: [PATCH 2/4] ARM: dts: DRA7: Add timer12 node
In-Reply-To: <1459892652-47845-1-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Message-ID: <1459892652-47845-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT node for Timer12 present on DRA7 family of
SoCs. Timer12 is present in PD_WKUPAON power domain, and
has the same capabilities as the other timers, except for
the fact that it serves as a secure timer on HS devices
and is clocked only from the secure 32K clock.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
Changes from previous post:
Drop status = "disabled" line

 arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 66c7924e5491..955d562c70f0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -773,6 +773,15 @@
 			ti,hwmods = "timer11";
 		};
 
+		timer12: timer at 4ae20000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4ae20000 0x80>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "timer12";
+			ti,timer-alwon;
+			ti,timer-secure;
+		};
+
 		timer13: timer at 48828000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x48828000 0x80>;
-- 
2.7.4
