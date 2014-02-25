From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Feb 2014 18:34:03 +0100
Subject: [PATCH v3 5/5] ARM: kirkwood: Add HP T5325 devices to
 {multi|mvebu}_v5_defconfig
In-Reply-To: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
References: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393349643-6652-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HP T5325 has a PCI based VGA controller. Add the frame buffer
driver, and frame buffer support to the defconfig's. Additionally
add the soc audio framework and the necessary codec.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/multi_v5_defconfig | 9 +++++++++
 arch/arm/configs/mvebu_v5_defconfig | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 2bc1e1707930..84ba24a0ead7 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
+CONFIG_MACH_T5325=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_IMX25_DT=y
 CONFIG_MACH_IMX27_DT=y
@@ -101,6 +102,12 @@ CONFIG_THERMAL=y
 CONFIG_KIRKWOOD_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_FB=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_KIRKWOOD_SOC=y
+CONFIG_SND_KIRKWOOD_SOC_T5325=y
 # CONFIG_ABX500_CORE is not set
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -150,6 +157,8 @@ CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
+CONFIG_STAGING=y
+CONFIG_FB_XGI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 2844636c0cf2..36484a37a1ca 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -11,6 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
+CONFIG_MACH_T5325=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
@@ -93,6 +94,12 @@ CONFIG_SENSORS_LM85=y
 CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_FB=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_KIRKWOOD_SOC=y
+CONFIG_SND_KIRKWOOD_SOC_T5325=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_HID_DRAGONRISE=y
@@ -137,6 +144,8 @@ CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
+CONFIG_STAGING=y
+CONFIG_FB_XGI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.8.5.3
