From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:29 +0200
Subject: [PATCH v2 25/38] ARM: orion5x: update I2C description at SoC level
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-26-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the Orion5x SoC definition to:

 * Not define a clock-frequency, as it should be described on a
   per-board basis.

 * Declare the appropriate clock reference, so that the driver can do
   correct divisors calculations for the I2C bus.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/orion5x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index b4c2234..203edde 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -56,7 +56,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <5>;
-				clock-frequency = <100000>;
+				clocks = <&core_clk 0>;
 				status = "disabled";
 			};
 
-- 
1.9.2
