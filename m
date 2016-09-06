From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:40:10 +0800
Subject: [PATCH 07/10] ARM: dts: berlin2q-marvell-dmp: add missing unit name
 to /memory node
In-Reply-To: <20160906084013.2887-1-jszhang@marvell.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
Message-ID: <20160906084013.2887-8-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning with W=1:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 33b2875..f485308 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -43,7 +43,7 @@
 	model = "Marvell BG2-Q DMP";
 	compatible = "marvell,berlin2q-dmp", "marvell,berlin2q", "marvell,berlin";
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000>;
 	};
-- 
2.9.3
