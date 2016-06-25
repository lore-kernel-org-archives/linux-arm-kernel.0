From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:45:06 +0200
Subject: [PATCH v2 09/14] ARM: dts: sun8i: Add cpu0 label to sun8i-h3.dtsi
In-Reply-To: <20160625034511.7966-1-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Message-ID: <20160625034511.7966-10-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Add label to the first cpu so that it can be referenced
from derived dts files.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
v2
- move clocks/clock-latency to sun8i-h3.dtsi  
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index d3c29cc..56f211e 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -52,7 +52,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
+			clocks = <&cpu>;
+			clock-latency = <244144>; /* 8 32k periods */
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
-- 
2.9.0
