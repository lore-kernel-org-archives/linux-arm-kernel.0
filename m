From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:55 +0300
Subject: [PATCH v2 6/8] arm: dts: lpc32xx: add external memory controller
 device node
In-Reply-To: <1445117757-8073-1-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
Message-ID: <1445117757-8073-7-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds a description of ARM PrimeCell PL175 memory
controller, which is found on NXP LPC32xx SoCs.

The controller supports up to 4 static memory devices mapped to
0xE000 0000 - 0xE3FF FFFF physical memory area.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- none, new change

 arch/arm/boot/dts/lpc32xx.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index be82992..a595a4b 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -32,7 +32,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		ranges = <0x20000000 0x20000000 0x30000000>;
+		ranges = <0x20000000 0x20000000 0x30000000>,
+			 <0xe0000000 0xe0000000 0x04000000>;
 
 		/*
 		 * Enable either SLC or MLC
@@ -86,6 +87,19 @@
 			interrupts = <0x1d 0>;
 		};
 
+		emc: memory-controller at 31080000 {
+			compatible = "arm,pl175", "arm,primecell";
+			reg = <0x31080000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0xe0000000 0x01000000>,
+				 <1 0xe1000000 0x01000000>,
+				 <2 0xe2000000 0x01000000>,
+				 <3 0xe3000000 0x01000000>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.1.4
