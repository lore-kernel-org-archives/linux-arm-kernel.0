From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 29 Sep 2013 20:36:41 +0200
Subject: [PATCH,
 FIX] ARM: mvebu: fix ReadyNAS 102 Power button GPIO to make it active
 high
Message-ID: <87ob7bh3uu.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


NETGEAR ReadyNAS 102 Power button definition in .dts file flags
associated GPIO active low instead of active high. This results
in reversed events reported by input subsystem (0 returned when
the button is pressed, 1 when released). This patch makes
associated GPIO active high to recover correct behaviour.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
RN102 .dts file sits in Linus tree only since 3.12-rc1 so I guess
no one has currently relied on current reversed behaviour, i.e.
this can be fixed w/o impact on any userspace program. As a side
note, the initial error is mine.

 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 05e4485..396949d 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -160,7 +160,7 @@
 		button at 1 {
 			label = "Power Button";
 			linux,code = <116>;     /* KEY_POWER */
-			gpios = <&gpio1 30 1>;
+			gpios = <&gpio1 30 0>;
 		};
 
 		button at 2 {
-- 
1.8.4.rc3
