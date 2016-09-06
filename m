From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:40:09 +0800
Subject: [PATCH 06/10] ARM: dts: berlin2: Add missing unit name to /soc node
In-Reply-To: <20160906084013.2887-1-jszhang@marvell.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
Message-ID: <20160906084013.2887-7-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning with W=1:

"Node /soc has a reg or ranges property, but no unit name"

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index c89a441..e5a1a32 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -90,7 +90,7 @@
 		clock-frequency = <25000000>;
 	};
 
-	soc {
+	soc at f7000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.9.3
