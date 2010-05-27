From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 10:58:57 +0200
Subject: [PATCH v2 4/4] mx27_defconfig: add audio support for eukrea_mbimx27
In-Reply-To: <1274950737-26498-3-git-send-email-eric@eukrea.com>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<1274950737-26498-2-git-send-email-eric@eukrea.com>
	<1274950737-26498-3-git-send-email-eric@eukrea.com>
Message-ID: <1274950737-26498-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/configs/mx27_defconfig |   49 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index e6b1310..8c3331d 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.34
-# Wed May 19 18:36:55 2010
+# Wed May 26 21:45:42 2010
 #
 CONFIG_ARM=y
 CONFIG_HAVE_PWM=y
@@ -21,6 +21,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_NEED_DMA_MAP_STATE=y
+CONFIG_FIQ=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -790,6 +791,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_PENMOUNT is not set
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_WM97XX is not set
 # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
 # CONFIG_TOUCHSCREEN_TSC2007 is not set
@@ -969,6 +971,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_HTC_I2CPLD is not set
+# CONFIG_UCB1400_CORE is not set
 # CONFIG_TPS65010 is not set
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
@@ -1064,7 +1067,49 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_SOUND is not set
+CONFIG_SOUND=y
+CONFIG_SOUND_OSS_CORE=y
+CONFIG_SOUND_OSS_CORE_PRECLAIM=y
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+CONFIG_SND_SEQUENCER=y
+# CONFIG_SND_SEQ_DUMMY is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
+# CONFIG_SND_SEQUENCER_OSS is not set
+# CONFIG_SND_HRTIMER is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
+CONFIG_SND_DRIVERS=y
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_VIRMIDI is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+# CONFIG_SND_ARM is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_USB is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_AC97_BUS=y
+CONFIG_SND_IMX_SOC=y
+CONFIG_SND_SOC_EUKREA_TLV320=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+# CONFIG_SND_SOC_ALL_CODECS is not set
+CONFIG_SND_SOC_TLV320AIC23=y
+# CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=y
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
-- 
1.6.3.3
