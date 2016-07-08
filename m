From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 08 Jul 2016 15:50:58 +0200
Subject: [PATCH v2] arm: collie_defconfig: convert to use libata PATA drivers
Message-ID: <1467985859-23500-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.  However there are still
some users (mostly old or/and embedded non-x86 systems) that
have not converted from using IDE subsystem to libata PATA
drivers.  This doesn't seem to be good thing in the long-term
for Linux as while there is less and less PATA systems left
in use:

* testing efforts are divided between two subsystems

* having duplicate drivers for same hardware confuses users

This patch converts collie_defconfig to use libata PATA
drivers.

Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- added Acked-by tag from Dmitry

 arch/arm/configs/collie_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 6c56ad0..4e6b68f 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -43,8 +43,9 @@ CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=1024
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_PCMCIA=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
-- 
1.9.1
