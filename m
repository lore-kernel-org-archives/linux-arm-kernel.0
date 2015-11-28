From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 28 Nov 2015 12:14:07 +0100
Subject: [PATCH 3/4] ARM: dt: mvebu: ix4-300d: Cleanup NAND partition ranges
In-Reply-To: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1448709248-21177-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prefix all partition reg properties to 32-bit to ease readability.
While at it, also remove a stale x in front of boot partition
offset and make some upper-case hex numbers lower-case.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com> 
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Benoit Masson <yahoo@perenite.com>
Cc: linux-arm-kernel at lists.infradead.org 
Cc: devicetree at vger.kernel.org 
Cc: linux-kernel at vger.kernel.org 
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 76781fd18624..13cf69a8d0fb 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -157,35 +157,35 @@
 
 					partition at 0 {
 						label = "u-boot";
-						reg = <0x0000000 0xe0000>;
+						reg = <0x00000000 0x000e0000>;
 						read-only;
 					};
 
 					partition at e0000 {
 						label = "u-boot-env";
-						reg = <0xe0000 0x20000>;
+						reg = <0x000e0000 0x00020000>;
 						read-only;
 					};
 
 					partition at 100000 {
 						label = "u-boot-env2";
-						reg = <0x100000 0x20000>;
+						reg = <0x00100000 0x00020000>;
 						read-only;
 					};
 
 					partition at 120000 {
 						label = "zImage";
-						reg = <0x120000 0x400000>;
+						reg = <0x00120000 0x00400000>;
 					};
 
 					partition at 520000 {
 						label = "initrd";
-						reg = <0x520000 0x400000>;
+						reg = <0x00520000 0x00400000>;
 					};
 
-					partition at xE00000 {
+					partition at e00000 {
 						label = "boot";
-						reg = <0xE00000 0x3F200000>;
+						reg = <0x00e00000 0x3f200000>;
 					};
 				};
 			};
-- 
2.1.4
