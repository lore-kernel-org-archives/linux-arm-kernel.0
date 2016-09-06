From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:55:57 +0800
Subject: [PATCH 3/3] arm64: dts: berlin4ct-dmp: add missing unit name to
 /memory node
In-Reply-To: <20160906085557.4019-1-jszhang@marvell.com>
References: <20160906085557.4019-1-jszhang@marvell.com>
Message-ID: <20160906085557.4019-4-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning with W=1:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
index 0d70d39..fae6c69 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
@@ -54,7 +54,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 1000000 {
 		device_type = "memory";
 		/* the first 16MB is for firmwares' usage */
 		reg = <0 0x01000000 0 0x7f000000>;
-- 
2.9.3
