From: ryan@presslab.us (Ryan Press)
Date: Fri, 29 Mar 2013 10:51:17 -0700
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
Message-ID: <1364579477-19018-1-git-send-email-ryan@presslab.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory size in the device tree is only 512 MB, but the
Mirabox actually has 1 GB.

Tested the change with memtester and no problems found.

Signed-off-by: Ryan Press <ryan@presslab.us>
---
 arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index dd0c57d..cfe3dd2 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -21,7 +21,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x20000000>; /* 512 MB */
+		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
 	soc {
-- 
1.8.1.2
