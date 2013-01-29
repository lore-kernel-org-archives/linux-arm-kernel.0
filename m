From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 29 Jan 2013 21:59:46 +0100
Subject: [PATCH] ARM: dove: convert serial DT nodes to clocks property
Message-ID: <1359493186-25589-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_serial now has support for using clocks property and we have
a DT clock provider. This patch replaces the hard coded clock-frequency
property with a clocks phandle to tclk.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 42eac1f..7b52463 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -55,7 +55,7 @@
 			reg = <0x12000 0x100>;
 			reg-shift = <2>;
 			interrupts = <7>;
-			clock-frequency = <166666667>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
@@ -64,7 +64,7 @@
 			reg = <0x12100 0x100>;
 			reg-shift = <2>;
 			interrupts = <8>;
-			clock-frequency = <166666667>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
@@ -73,7 +73,7 @@
 			reg = <0x12000 0x100>;
 			reg-shift = <2>;
 			interrupts = <9>;
-			clock-frequency = <166666667>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
@@ -82,7 +82,7 @@
 			reg = <0x12100 0x100>;
 			reg-shift = <2>;
 			interrupts = <10>;
-			clock-frequency = <166666667>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
-- 
1.7.10.4
