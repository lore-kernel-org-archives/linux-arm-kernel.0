From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 20 Oct 2014 15:56:04 +0300
Subject: [PATCH v2 3/3] ARM: dts: keystone: add generic pd controller node
In-Reply-To: <1413809764-21995-1-git-send-email-grygorii.strashko@ti.com>
References: <1413809764-21995-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1413809764-21995-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TI Keystone 2 Generic Power Domain Controller node and attach
the Davinci MDIO device to it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 5d3e83f..c669d0d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -85,6 +85,11 @@
 
 		/include/ "keystone-clocks.dtsi"
 
+		pm_controller: pm-controller {
+			compatible = "ti,keystone-powerdomain";
+			#power-domain-cells = <0>;
+		};
+
 		uart0: serial at 02530c00 {
 			compatible = "ns16550a";
 			current-speed = <115200>;
@@ -275,6 +280,7 @@
 			status = "disabled";
 			clocks = <&clkpa>;
 			clock-names = "fck";
+			power-domains = <&pm_controller>;
 			bus_freq	= <2500000>;
 		};
 
-- 
1.9.1
