From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Mar 2013 15:12:15 +0000
Subject: [PATCH] ARM: mvebu: fix RAM size for Armada XP board DB-MV784MP-GP
In-Reply-To: <20130216164457.GA23237@titan.lakedaemon.net>
References: <20130216164457.GA23237@titan.lakedaemon.net>
Message-ID: <1363101135-21635-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board is supplied with a 4GB RAM module.  This value can be
overridden by the bootloader based on probed memory size.  We set it to
a reasonable value here.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
As promised, catching this fix in the -rc cycle.

For those not familiar, earlier versions of the patch adding this board listed
3GB because that is all that was visible.  I mistaken applied v3 of the patch
instead of v4 which properly listed 4GB.  This patch cleans up my error.

 arch/arm/boot/dts/armada-xp-gp.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1c8afe2..4a2776a 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -28,12 +28,11 @@
 		device_type = "memory";
 
 		/*
-		 * 4 GB of plug-in RAM modules by default but only 3GB
-		 * are visible, the amount of memory available can be
-		 * changed by the bootloader according the size of the
-		 * module actually plugged
+		 * 4 GB of plug-in RAM modules by default. The amount of memory
+		 * available can be changed by the bootloader according the
+		 * size of the module actually plugged
 		 */
-		reg = <0x00000000 0xC0000000>;
+		reg = <0x00000000 0xD0000000>;
 	};
 
 	soc {
-- 
1.8.1.5
