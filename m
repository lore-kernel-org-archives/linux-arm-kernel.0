From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:51 +0900
Subject: [PATCH 4/9] ARM: shmobile: Update r7s72100 DTS to include CPU
 frequency
In-Reply-To: <cover.1403487831.git.horms+renesas@verge.net.au>
References: <cover.1403487831.git.horms+renesas@verge.net.au>
Message-ID: <005407fdf1c65a06fc0a9c588408f57e2eacef7c.1403487831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add CPU Frequency information to the r7s72100 DTS file. This
will allow us to use the shared C code on r7s72100 and Genmai
which reads out the clock frequency from DT and calculates the
delay settings from there.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index f50fbc8..bdee225 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -144,6 +144,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <400000000>;
 		};
 	};
 
-- 
2.0.0.rc2
