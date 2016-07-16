From: jm@lentin.co.uk (Jamie Lentin)
Date: Sat, 16 Jul 2016 15:28:59 +0100
Subject: [PATCH v0 01/10] arm: orion5x: Add required properties for orion-wdt
 to DT node
In-Reply-To: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1468679348-10522-2-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

orion-wdt refuses to start without these properties defined, so lift
definitions out of kirkwood/dove.dtsi

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/orion5x.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index e1b6d2a..fbccfbb 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -144,9 +144,10 @@
 
 			wdt: wdt at 20300 {
 				compatible = "marvell,orion-wdt";
-				reg = <0x20300 0x28>;
+				reg = <0x20300 0x28>, <0x20108 0x4>;
 				interrupt-parent = <&bridge_intc>;
 				interrupts = <3>;
+				clocks = <&core_clk 0>;
 				status = "okay";
 			};
 
-- 
2.8.1
