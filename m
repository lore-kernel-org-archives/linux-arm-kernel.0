From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 13 Jul 2016 14:18:49 -0400
Subject: [PATCH] ARM: dts: NSP: Correct RAM amount for BCM958625HR board
Message-ID: <1468433929-12232-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM958625HR board has 2GB of RAM available.  Increase the amount
from 512MB to 2GB and add the device type to the memory entry.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 4239e58..66c658a 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -47,7 +47,8 @@
 	};
 
 	memory {
-		reg = <0x60000000 0x20000000>;
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
 	};
 };
 
-- 
1.9.1
