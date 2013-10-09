From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:18 +0900
Subject: [PATCH 08/13] ARM: shmobile: r8a7791 SMP device tree node
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <15ab426c0f1935016ea52cfedf0d808f8c79dd1e.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a device node for the r8a7791 secondary CPU core.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a1a9e5c..fea5cfe 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -25,6 +25,13 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
-- 
1.8.4
