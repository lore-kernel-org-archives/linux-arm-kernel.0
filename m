From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 16:40:11 +0800
Subject: [PATCH 08/10] ARM: dts: chromecast: add missing unit name to /memory
 node
In-Reply-To: <20160906084013.2887-1-jszhang@marvell.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
Message-ID: <20160906084013.2887-9-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning with W=1:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 8ba8b50..ca24def 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -50,7 +50,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
-- 
2.9.3
