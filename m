From: woogyom.kim@gmail.com (Milo Kim)
Date: Mon,  5 Dec 2016 11:00:32 +0900
Subject: [PATCH 2/2] ARM: dts: sun8i: Specify memblock for Nano Pi Neo
In-Reply-To: <20161205020032.26586-1-woogyom.kim@gmail.com>
References: <20161205020032.26586-1-woogyom.kim@gmail.com>
Message-ID: <20161205020032.26586-2-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has DDR3 256MB. This patch helps scanning the memory and
adding memblock through the DT.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 8d2cc6e..433f55d 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -45,4 +45,9 @@
 / {
 	model = "FriendlyARM NanoPi NEO";
 	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x10000000>;
+	};
 };
-- 
2.9.3
