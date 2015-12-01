From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Dec 2015 14:42:37 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4 master clock can run at 200MHz now
Message-ID: <1448977357-19396-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the change of frequency a SAMA5D4 can reach, we have to modify the
maximum clock specification for the master clock, up to 200MHz now.

It avoids the wrong message saying that "master clk is overclocked" for this
configuration.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 2193637b9cd2..fce9a984aa6f 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -451,7 +451,7 @@
 					interrupt-parent = <&pmc>;
 					interrupts = <AT91_PMC_MCKRDY>;
 					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
-					atmel,clk-output-range = <125000000 177000000>;
+					atmel,clk-output-range = <125000000 200000000>;
 					atmel,clk-divisors = <1 2 4 3>;
 				};
 
-- 
2.1.3
