From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:55:56 +0800
Subject: [PATCH 2/3] arm64: dts: berlin4ct-stb: add missing unit name to
 /memory node
In-Reply-To: <20160906085557.4019-1-jszhang@marvell.com>
References: <20160906085557.4019-1-jszhang@marvell.com>
Message-ID: <20160906085557.4019-3-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning with W=1:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
index 348c37e..d47edad 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
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
