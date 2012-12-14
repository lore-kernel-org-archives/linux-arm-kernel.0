From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 14 Dec 2012 14:34:18 -0600
Subject: [PATCH] ARM: dts: OMAP2420: Correct H4 board memory size
Message-ID: <1355517258-30745-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system memory node for the OMAP2420 H4 was incorrectly defined as
start address followed by end address, instead of start address and
size. No noticable side-effects were observed but fix this for
correctness.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2420-h4.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 77b84e1..9b0d077 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -15,6 +15,6 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x84000000>; /* 64 MB */
+		reg = <0x80000000 0x4000000>; /* 64 MB */
 	};
 };
-- 
1.7.10.4
