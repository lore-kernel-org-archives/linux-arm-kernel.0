From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:50 -0700
Subject: [PATCH 7/7] ARM: defconfig: Update qcom_defconfig
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445403470-17434-7-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables smem, smd, rpm, regulators, pmic pinctrl and hwspinlock as
these platform features are now merged. It enables gpio-keys as this is
used by most boards and enables fhandle and cgroups, so we can boot
systemd.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

MSM_IOMMU is marked as BROKEN as of next-20151020, the other options
that is disabled are done so because they are now default on.

 arch/arm/configs/qcom_defconfig | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index ff7985ba226e..0efe0741b5be 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -1,8 +1,10 @@
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS_ALL=y
@@ -25,7 +27,6 @@ CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_CLEANCACHE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
@@ -78,6 +79,7 @@ CONFIG_USB_USBNET=y
 # CONFIG_USB_NET_ZAURUS is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_TOUCHSCREEN=y
@@ -99,16 +101,21 @@ CONFIG_PINCTRL_APQ8084=y
 CONFIG_PINCTRL_IPQ8064=y
 CONFIG_PINCTRL_MSM8960=y
 CONFIG_PINCTRL_MSM8X74=y
+CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIOLIB=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_CHARGER_QCOM_SMBB=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_THERMAL=y
 CONFIG_MFD_QCOM_RPM=y
+CONFIG_MFD_SPMI_PMIC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_RPM=y
+CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_FB=y
 CONFIG_SOUND=y
@@ -145,16 +152,17 @@ CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_LCC_8960=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-CONFIG_MSM_IOMMU=y
+CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_SMEM=y
+CONFIG_QCOM_SMD=y
+CONFIG_QCOM_SMD_RPM=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT4_FS=y
 CONFIG_FUSE_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.4.2
