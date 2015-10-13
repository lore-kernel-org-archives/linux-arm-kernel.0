From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 13 Oct 2015 19:20:37 +0300
Subject: [PATCH v2 4/5] arm: dts: lpc32xx: add reg property to cpu device node
In-Reply-To: <1444694045-22000-5-git-send-email-vz@mleia.com>
References: <1444694045-22000-5-git-send-email-vz@mleia.com>
Message-ID: <1444753237-6451-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to device tree bindings for ARM cpus cpu node must contain a
reg property for enumeration scheme.

The change adds reg = <0x0> indicating that the processor does not
have CPU identification register and updates cell settings.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- instead of removing address/size cells properties update them
  in accordance to ARM CPU device tree bindings, thanks to Joachim for review

The change replaces 4/5 "arm: dts: lpc32xx: remove unneeded cell settings from cpus"

 arch/arm/boot/dts/lpc32xx.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index dcb52cb..343a94f 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -18,12 +18,13 @@
 	interrupt-parent = <&mic>;
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu at 0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0x0>;
 		};
 	};
 
-- 
2.1.4
