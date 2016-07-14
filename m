From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 14 Jul 2016 16:14:17 -0400
Subject: [PATCH v2] ARM: dts: NSP: Correct RAM amount for BCM958625HR board
Message-ID: <1468527257-3339-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM958625HR board has 2GB of RAM available.  Increase the amount
from 512MB to 2GB and add the device type to the memory entry.

Fixes: 9a4865d42fe5 ("ARM: dts: NSP: Specify RAM amount for BCM958625HR board")
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 4239e58..4caa8fa 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -47,7 +47,8 @@
 	};
 
 	memory {
-		reg = <0x60000000 0x20000000>;
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
 	};
 };
 
-- 
1.9.1
