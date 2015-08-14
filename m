From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 14 Aug 2015 19:04:25 +0200
Subject: [RFT PATCH] arm: ixp4xx_defconfig: convert to use libata PATA drivers
In-Reply-To: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1439571876-13758-10-git-send-email-b.zolnierkie@samsung.com>
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

This patch converts ixp4xx_defconfig to use libata PATA
drivers.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/arm/configs/ixp4xx_defconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 24636cf..6414f24 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -127,16 +127,17 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_EEPROM_LEGACY=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_HPT366=y
-CONFIG_BLK_DEV_PDC202XX_NEW=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_SATA_VIA=y
 CONFIG_PATA_ARTOP=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PATA_HPT366=y
+CONFIG_PATA_HPT37X=y
+CONFIG_PATA_HPT3X2N=y
+CONFIG_PATA_PDC2027X=y
 CONFIG_PATA_IXP4XX_CF=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-- 
1.9.1
