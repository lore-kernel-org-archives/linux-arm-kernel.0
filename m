From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:52 +0300
Subject: [PATCH v2 3/8] arm: dts: lpc32xx: add reg property to cpu device node
In-Reply-To: <1445117757-8073-1-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
Message-ID: <1445117757-8073-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to device tree bindings for ARM cpus cpu node must contain a
reg property for enumeration scheme.

The change adds reg = <0x0> indicating that the processor does not
have CPU identification register and updates cell settings.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- new change, replaced v1 4/5 "arm: dts: lpc32xx: remove unneeded cell settings from cpus"

 arch/arm/boot/dts/lpc32xx.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 00570b3..fb0e9ae 100644
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
