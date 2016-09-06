From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:40:04 +0800
Subject: [PATCH 01/10] ARM: dts: berlin2q: Remove skeleton.dtsi inclusion
In-Reply-To: <20160906084013.2887-1-jszhang@marvell.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
Message-ID: <20160906084013.2887-2-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in [1], "there are a number of problems with skeleton.dtsi,
and it would be prefereable to remove it entirely." This patch is to
remove skeleton.dtsi inclusion from berlin2q.

[1] http://www.spinics.net/lists/arm-kernel/msg528080.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 2c34bfb..4554945 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -37,11 +37,11 @@
 #include <dt-bindings/clock/berlin2q.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	model = "Marvell Armada 1500 pro (BG2-Q) SoC";
 	compatible = "marvell,berlin2q", "marvell,berlin";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		serial0 = &uart0;
-- 
2.9.3
