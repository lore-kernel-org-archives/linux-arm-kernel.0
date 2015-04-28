From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 14:08:03 +0200
Subject: [PATCH 1/2] ARM: shmobile: defconfig: Replace USB_RCAR_GEN2_PHY by
 PHY_RCAR_GEN2
Message-ID: <1430222884-2095-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy-only USB_RCAR_GEN2_PHY driver was replaced by the DT-only
PHY_RCAR_GEN2 driver.

Refresh the defconfig using "make savedefconfig" while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Oops, CONFIG_USB_RCAR_GEN2_PHY shouldn't have been in a multiplatform
defconfig, as it supports legacy platform data only.

 arch/arm/configs/shmobile_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b58618e2d13c51c8..9961fbd633f8d165 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -121,7 +121,6 @@ CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_DA9063=y
-CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
@@ -160,7 +159,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_RCAR_PHY=y
-CONFIG_USB_RCAR_GEN2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
 CONFIG_USB_ETH=y
@@ -182,6 +180,8 @@ CONFIG_IIO=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_RENESAS_TPU=y
+CONFIG_GENERIC_PHY=y
+CONFIG_PHY_RCAR_GEN2=y
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
-- 
1.9.1
