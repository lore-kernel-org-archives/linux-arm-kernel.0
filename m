From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:40:06 +0800
Subject: [PATCH 03/10] ARM: dts: berlin2: Remove skeleton.dtsi inclusion
In-Reply-To: <20160906084013.2887-1-jszhang@marvell.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
Message-ID: <20160906084013.2887-4-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in [1], "there are a number of problems with skeleton.dtsi,
and it would be prefereable to remove it entirely." This patch is to
remove skeleton.dtsi inclusion from berlin2.

[1] http://www.spinics.net/lists/arm-kernel/msg528080.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index ae81009..c89a441 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -39,13 +39,14 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/berlin2.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	model = "Marvell Armada 1500 (BG2) SoC";
 	compatible = "marvell,berlin2", "marvell,berlin";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		serial0 = &uart0;
-- 
2.9.3
