From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri,  9 Oct 2009 15:02:20 +0100
Subject: [PATCH 4/6] ARM: remove references to non-existent fastfpe
In-Reply-To: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Message-ID: <1255096942-10451-4-git-send-email-alan-jenkins@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	# Do we have FASTFPE?
	FASTFPE		:=arch/arm/fastfpe
	ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
	FASTFPE_OBJ	:=$(FASTFPE)/
	endif
	fastfpe

We don't have FASTFPE.  If this code still exists out of tree, it can
surely maintain its own Makefile and Kconfig entries.  Let's not confuse
users by allowing them to select FASTFPE, and then silently not building
it.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/Kconfig                               |   14 --------------
 arch/arm/Makefile                              |    7 -------
 arch/arm/configs/acs5k_defconfig               |    1 -
 arch/arm/configs/acs5k_tiny_defconfig          |    1 -
 arch/arm/configs/afeb9260_defconfig            |    1 -
 arch/arm/configs/ams_delta_defconfig           |    1 -
 arch/arm/configs/assabet_defconfig             |    1 -
 arch/arm/configs/at91cap9adk_defconfig         |    1 -
 arch/arm/configs/at91rm9200dk_defconfig        |    1 -
 arch/arm/configs/at91rm9200ek_defconfig        |    1 -
 arch/arm/configs/at91sam9260ek_defconfig       |    1 -
 arch/arm/configs/at91sam9261ek_defconfig       |    1 -
 arch/arm/configs/at91sam9263ek_defconfig       |    1 -
 arch/arm/configs/at91sam9g20ek_defconfig       |    1 -
 arch/arm/configs/at91sam9rlek_defconfig        |    1 -
 arch/arm/configs/ateb9200_defconfig            |    1 -
 arch/arm/configs/badge4_defconfig              |    1 -
 arch/arm/configs/cam60_defconfig               |    1 -
 arch/arm/configs/carmeva_defconfig             |    1 -
 arch/arm/configs/cerfcube_defconfig            |    3 +--
 arch/arm/configs/cm_x2xx_defconfig             |    1 -
 arch/arm/configs/cm_x300_defconfig             |    1 -
 arch/arm/configs/colibri_pxa270_defconfig      |    1 -
 arch/arm/configs/colibri_pxa300_defconfig      |    1 -
 arch/arm/configs/collie_defconfig              |    1 -
 arch/arm/configs/corgi_defconfig               |    1 -
 arch/arm/configs/cpu9260_defconfig             |    1 -
 arch/arm/configs/cpu9g20_defconfig             |    1 -
 arch/arm/configs/cpuat91_defconfig             |    1 -
 arch/arm/configs/csb337_defconfig              |    1 -
 arch/arm/configs/csb637_defconfig              |    1 -
 arch/arm/configs/ebsa110_defconfig             |    1 -
 arch/arm/configs/ecbat91_defconfig             |    1 -
 arch/arm/configs/edb7211_defconfig             |    1 -
 arch/arm/configs/em_x270_defconfig             |    1 -
 arch/arm/configs/ep93xx_defconfig              |    1 -
 arch/arm/configs/eseries_pxa_defconfig         |    1 -
 arch/arm/configs/ezx_defconfig                 |    1 -
 arch/arm/configs/footbridge_defconfig          |    1 -
 arch/arm/configs/fortunet_defconfig            |    3 +--
 arch/arm/configs/h3600_defconfig               |    1 -
 arch/arm/configs/h5000_defconfig               |    1 -
 arch/arm/configs/h7201_defconfig               |    1 -
 arch/arm/configs/h7202_defconfig               |    1 -
 arch/arm/configs/hackkit_defconfig             |    1 -
 arch/arm/configs/integrator_defconfig          |    1 -
 arch/arm/configs/iop13xx_defconfig             |    1 -
 arch/arm/configs/iop32x_defconfig              |    1 -
 arch/arm/configs/iop33x_defconfig              |    1 -
 arch/arm/configs/ixp2000_defconfig             |    1 -
 arch/arm/configs/ixp23xx_defconfig             |    1 -
 arch/arm/configs/ixp4xx_defconfig              |    1 -
 arch/arm/configs/jornada720_defconfig          |    1 -
 arch/arm/configs/kafa_defconfig                |    1 -
 arch/arm/configs/kb9202_defconfig              |    1 -
 arch/arm/configs/ks8695_defconfig              |    1 -
 arch/arm/configs/lart_defconfig                |    1 -
 arch/arm/configs/loki_defconfig                |    1 -
 arch/arm/configs/lpd270_defconfig              |    1 -
 arch/arm/configs/lpd7a400_defconfig            |    1 -
 arch/arm/configs/lpd7a404_defconfig            |    1 -
 arch/arm/configs/lubbock_defconfig             |    1 -
 arch/arm/configs/lusl7200_defconfig            |    1 -
 arch/arm/configs/magician_defconfig            |    1 -
 arch/arm/configs/mainstone_defconfig           |    1 -
 arch/arm/configs/mv78xx0_defconfig             |    1 -
 arch/arm/configs/mx1_defconfig                 |    1 -
 arch/arm/configs/mx1ads_defconfig              |    1 -
 arch/arm/configs/mx21_defconfig                |    1 -
 arch/arm/configs/mx27_defconfig                |    1 -
 arch/arm/configs/mx3_defconfig                 |    1 -
 arch/arm/configs/n770_defconfig                |    1 -
 arch/arm/configs/n8x0_defconfig                |    1 -
 arch/arm/configs/neocore926_defconfig          |    1 -
 arch/arm/configs/neponset_defconfig            |    1 -
 arch/arm/configs/netwinder_defconfig           |    1 -
 arch/arm/configs/netx_defconfig                |    1 -
 arch/arm/configs/nhk8815_defconfig             |    1 -
 arch/arm/configs/omap3_beagle_defconfig        |    1 -
 arch/arm/configs/omap3_evm_defconfig           |    1 -
 arch/arm/configs/omap3_pandora_defconfig       |    1 -
 arch/arm/configs/omap_2430sdp_defconfig        |    1 -
 arch/arm/configs/omap_apollon_2420_defconfig   |    1 -
 arch/arm/configs/omap_generic_1510_defconfig   |    1 -
 arch/arm/configs/omap_generic_1610_defconfig   |    1 -
 arch/arm/configs/omap_generic_1710_defconfig   |    1 -
 arch/arm/configs/omap_generic_2420_defconfig   |    1 -
 arch/arm/configs/omap_h2_1610_defconfig        |    1 -
 arch/arm/configs/omap_h4_2420_defconfig        |    1 -
 arch/arm/configs/omap_innovator_1510_defconfig |    1 -
 arch/arm/configs/omap_innovator_1610_defconfig |    1 -
 arch/arm/configs/omap_ldp_defconfig            |    1 -
 arch/arm/configs/omap_osk_5912_defconfig       |    1 -
 arch/arm/configs/omap_perseus2_730_defconfig   |    1 -
 arch/arm/configs/omap_zoom2_defconfig          |    1 -
 arch/arm/configs/onearm_defconfig              |    1 -
 arch/arm/configs/orion5x_defconfig             |    1 -
 arch/arm/configs/palmte_defconfig              |    1 -
 arch/arm/configs/palmtt_defconfig              |    1 -
 arch/arm/configs/palmz71_defconfig             |    1 -
 arch/arm/configs/palmz72_defconfig             |    1 -
 arch/arm/configs/picotux200_defconfig          |    1 -
 arch/arm/configs/pleb_defconfig                |    1 -
 arch/arm/configs/pnx4008_defconfig             |    1 -
 arch/arm/configs/pxa168_defconfig              |    1 -
 arch/arm/configs/pxa255-idp_defconfig          |    1 -
 arch/arm/configs/pxa3xx_defconfig              |    1 -
 arch/arm/configs/pxa910_defconfig              |    1 -
 arch/arm/configs/qil-a9260_defconfig           |    1 -
 arch/arm/configs/realview-smp_defconfig        |    1 -
 arch/arm/configs/realview_defconfig            |    1 -
 arch/arm/configs/s3c2410_defconfig             |    1 -
 arch/arm/configs/s3c6400_defconfig             |    1 -
 arch/arm/configs/s5pc100_defconfig             |    1 -
 arch/arm/configs/sam9_l9260_defconfig          |    1 -
 arch/arm/configs/shannon_defconfig             |    1 -
 arch/arm/configs/shark_defconfig               |    1 -
 arch/arm/configs/simpad_defconfig              |    1 -
 arch/arm/configs/spitz_defconfig               |    1 -
 arch/arm/configs/stmp378x_defconfig            |    1 -
 arch/arm/configs/stmp37xx_defconfig            |    1 -
 arch/arm/configs/sx1_defconfig                 |    1 -
 arch/arm/configs/tct_hammer_defconfig          |    1 -
 arch/arm/configs/trizeps4_defconfig            |    1 -
 arch/arm/configs/u300_defconfig                |    1 -
 arch/arm/configs/usb-a9260_defconfig           |    1 -
 arch/arm/configs/usb-a9263_defconfig           |    1 -
 arch/arm/configs/versatile_defconfig           |    1 -
 arch/arm/configs/viper_defconfig               |    1 -
 arch/arm/configs/w90p910_defconfig             |    1 -
 arch/arm/configs/xcep_defconfig                |    1 -
 arch/arm/kernel/setup.c                        |    2 +-
 132 files changed, 3 insertions(+), 153 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 085644c..08d71d1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1437,20 +1437,6 @@ config FPE_NWFPE_XP
 
 	  You almost certainly want to say N here.
 
-config FPE_FASTFPE
-	bool "FastFPE math emulation (EXPERIMENTAL)"
-	depends on (!AEABI || OABI_COMPAT) && !CPU_32v3 && EXPERIMENTAL
-	---help---
-	  Say Y here to include the FAST floating point emulator in the kernel.
-	  This is an experimental much faster emulator which now also has full
-	  precision for the mantissa.  It does not support any exceptions.
-	  It is very simple, and approximately 3-6 times faster than NWFPE.
-
-	  It should be sufficient for most programs.  It may be not suitable
-	  for scientific calculations, but you have to check this for yourself.
-	  If you do not feel you need a faster FP emulation you should better
-	  choose NWFPE.
-
 config VFP
 	bool "VFP-format floating point maths"
 	depends on CPU_V6 || CPU_ARM926T || CPU_V7 || CPU_FEROCEON
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a73caaf..7153c56 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -211,17 +211,10 @@ endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-# Do we have FASTFPE?
-FASTFPE		:=arch/arm/fastfpe
-ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
-FASTFPE_OBJ	:=$(FASTFPE)/
-endif
-
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
 core-y				+= $(machdirs) $(platdirs)
 core-$(CONFIG_FPE_NWFPE)	+= arch/arm/nwfpe/
-core-$(CONFIG_FPE_FASTFPE)	+= $(FASTFPE_OBJ)
 core-$(CONFIG_VFP)		+= arch/arm/vfp/
 
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
diff --git a/arch/arm/configs/acs5k_defconfig b/arch/arm/configs/acs5k_defconfig
index 1cab4e7..d41c88b 100644
--- a/arch/arm/configs/acs5k_defconfig
+++ b/arch/arm/configs/acs5k_defconfig
@@ -280,7 +280,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/acs5k_tiny_defconfig b/arch/arm/configs/acs5k_tiny_defconfig
index 8e3d084..e15fad1 100644
--- a/arch/arm/configs/acs5k_tiny_defconfig
+++ b/arch/arm/configs/acs5k_tiny_defconfig
@@ -260,7 +260,6 @@ CONFIG_CMDLINE="console=ttyAM0,115200 init=/bin/sh"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/afeb9260_defconfig b/arch/arm/configs/afeb9260_defconfig
index f7a272c..5065a42 100644
--- a/arch/arm/configs/afeb9260_defconfig
+++ b/arch/arm/configs/afeb9260_defconfig
@@ -302,7 +302,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
index 7647325..6bf2389 100644
--- a/arch/arm/configs/ams_delta_defconfig
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -286,7 +286,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200n8 root=/dev/ram0 initrd=0x11c00000,
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index c66dd39..1c3ff6d 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -169,7 +169,6 @@ CONFIG_CPU_FREQ_SA1110=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/at91cap9adk_defconfig b/arch/arm/configs/at91cap9adk_defconfig
index bc6bd9f..9e2fba5 100644
--- a/arch/arm/configs/at91cap9adk_defconfig
+++ b/arch/arm/configs/at91cap9adk_defconfig
@@ -253,7 +253,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/ram0 rw"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/at91rm9200dk_defconfig b/arch/arm/configs/at91rm9200dk_defconfig
index 238b218..d93d34b 100644
--- a/arch/arm/configs/at91rm9200dk_defconfig
+++ b/arch/arm/configs/at91rm9200dk_defconfig
@@ -200,7 +200,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/at91rm9200ek_defconfig b/arch/arm/configs/at91rm9200ek_defconfig
index 9f7a99a..68ab770 100644
--- a/arch/arm/configs/at91rm9200ek_defconfig
+++ b/arch/arm/configs/at91rm9200ek_defconfig
@@ -191,7 +191,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/at91sam9260ek_defconfig b/arch/arm/configs/at91sam9260ek_defconfig
index 98e2f3d..c8a12ec 100644
--- a/arch/arm/configs/at91sam9260ek_defconfig
+++ b/arch/arm/configs/at91sam9260ek_defconfig
@@ -257,7 +257,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/at91sam9261ek_defconfig b/arch/arm/configs/at91sam9261ek_defconfig
index 1494561..a8ab03b 100644
--- a/arch/arm/configs/at91sam9261ek_defconfig
+++ b/arch/arm/configs/at91sam9261ek_defconfig
@@ -250,7 +250,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/at91sam9263ek_defconfig b/arch/arm/configs/at91sam9263ek_defconfig
index 21599f3..2d54ad8 100644
--- a/arch/arm/configs/at91sam9263ek_defconfig
+++ b/arch/arm/configs/at91sam9263ek_defconfig
@@ -250,7 +250,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/at91sam9g20ek_defconfig b/arch/arm/configs/at91sam9g20ek_defconfig
index 7e018a0..2a16c0e 100644
--- a/arch/arm/configs/at91sam9g20ek_defconfig
+++ b/arch/arm/configs/at91sam9g20ek_defconfig
@@ -261,7 +261,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/at91sam9rlek_defconfig b/arch/arm/configs/at91sam9rlek_defconfig
index e2df81a..87d46a2 100644
--- a/arch/arm/configs/at91sam9rlek_defconfig
+++ b/arch/arm/configs/at91sam9rlek_defconfig
@@ -248,7 +248,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,17105363 root=/de
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/ateb9200_defconfig b/arch/arm/configs/ateb9200_defconfig
index a19e824..b62139c 100644
--- a/arch/arm/configs/ateb9200_defconfig
+++ b/arch/arm/configs/ateb9200_defconfig
@@ -202,7 +202,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index f264846..53d0af6 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -172,7 +172,6 @@ CONFIG_CPU_FREQ_SA1100=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/cam60_defconfig b/arch/arm/configs/cam60_defconfig
index 8448108..0c721ae 100644
--- a/arch/arm/configs/cam60_defconfig
+++ b/arch/arm/configs/cam60_defconfig
@@ -269,7 +269,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 noinitrd root=/dev/mtdblock0 rootfstype=jff
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/carmeva_defconfig b/arch/arm/configs/carmeva_defconfig
index d392833..ed1baca 100644
--- a/arch/arm/configs/carmeva_defconfig
+++ b/arch/arm/configs/carmeva_defconfig
@@ -150,7 +150,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index 2b4c066..594e4c8 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -178,8 +178,7 @@ CONFIG_CPU_FREQ_SA1110=y
 #
 # At least one emulation must be selected
 #
-# CONFIG_FPE_NWFPE is not set
-CONFIG_FPE_FASTFPE=y
+CONFIG_FPE_NWFPE=y
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/cm_x2xx_defconfig b/arch/arm/configs/cm_x2xx_defconfig
index 797b790..3745004 100644
--- a/arch/arm/configs/cm_x2xx_defconfig
+++ b/arch/arm/configs/cm_x2xx_defconfig
@@ -314,7 +314,6 @@ CONFIG_CMDLINE="root=1f03 mem=32M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index d18d21b..a71ae8f 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -335,7 +335,6 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 4cf3bde..d6a59b4 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -287,7 +287,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
index 4774a36..f6bfbd6 100644
--- a/arch/arm/configs/colibri_pxa300_defconfig
+++ b/arch/arm/configs/colibri_pxa300_defconfig
@@ -298,7 +298,6 @@ CONFIG_CPU_IDLE_GOV_LADDER=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 1aa6224..379966f 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -203,7 +203,6 @@ CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index d6cd165..aaef00b 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -308,7 +308,6 @@ CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/cpu9260_defconfig b/arch/arm/configs/cpu9260_defconfig
index 601e7f3..cbc2b98 100644
--- a/arch/arm/configs/cpu9260_defconfig
+++ b/arch/arm/configs/cpu9260_defconfig
@@ -313,7 +313,6 @@ CONFIG_CMDLINE=""
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/cpu9g20_defconfig b/arch/arm/configs/cpu9g20_defconfig
index b5b9cbb..276250c 100644
--- a/arch/arm/configs/cpu9g20_defconfig
+++ b/arch/arm/configs/cpu9g20_defconfig
@@ -303,7 +303,6 @@ CONFIG_CMDLINE=""
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/cpuat91_defconfig b/arch/arm/configs/cpuat91_defconfig
index 4901827..38b37f5 100644
--- a/arch/arm/configs/cpuat91_defconfig
+++ b/arch/arm/configs/cpuat91_defconfig
@@ -313,7 +313,6 @@ CONFIG_CMDLINE=""
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/csb337_defconfig b/arch/arm/configs/csb337_defconfig
index 29f68c2..79855a3 100644
--- a/arch/arm/configs/csb337_defconfig
+++ b/arch/arm/configs/csb337_defconfig
@@ -275,7 +275,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,38400 initrd=0x20410000,3145728 root=/dev/
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/csb637_defconfig b/arch/arm/configs/csb637_defconfig
index f7b60ce..a46bfe7 100644
--- a/arch/arm/configs/csb637_defconfig
+++ b/arch/arm/configs/csb637_defconfig
@@ -297,7 +297,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,38400 initrd=0x20410000,3145728 root=/dev/
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ebsa110_defconfig b/arch/arm/configs/ebsa110_defconfig
index afcfff6..0102744 100644
--- a/arch/arm/configs/ebsa110_defconfig
+++ b/arch/arm/configs/ebsa110_defconfig
@@ -140,7 +140,6 @@ CONFIG_CMDLINE="root=/dev/nfs rw mem=16M console=ttyS1,38400n8"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-CONFIG_FPE_FASTFPE=y
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ecbat91_defconfig b/arch/arm/configs/ecbat91_defconfig
index ca52073..333027c 100644
--- a/arch/arm/configs/ecbat91_defconfig
+++ b/arch/arm/configs/ecbat91_defconfig
@@ -266,7 +266,6 @@ CONFIG_CMDLINE="rootfstype=reiserfs root=/dev/mmcblk0p1 console=ttyS0,115200n8 r
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/edb7211_defconfig b/arch/arm/configs/edb7211_defconfig
index 6ba7355..2312f25 100644
--- a/arch/arm/configs/edb7211_defconfig
+++ b/arch/arm/configs/edb7211_defconfig
@@ -137,7 +137,6 @@ CONFIG_CMDLINE=""
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/em_x270_defconfig b/arch/arm/configs/em_x270_defconfig
index e9955b7..a9c2f7a 100644
--- a/arch/arm/configs/em_x270_defconfig
+++ b/arch/arm/configs/em_x270_defconfig
@@ -299,7 +299,6 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=m
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 3fb083b..683e90b 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -283,7 +283,6 @@ CONFIG_CMDLINE="console=ttyAM0,115200 root=/dev/nfs ip=bootp"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index b6c5cbb..3d24bad 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -297,7 +297,6 @@ CONFIG_ATAGS_PROC=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index d5ee16e..8cd6000 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -279,7 +279,6 @@ CONFIG_ATAGS_PROC=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 6ace512..c7924d3 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -148,7 +148,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/fortunet_defconfig b/arch/arm/configs/fortunet_defconfig
index 65dc73a..e04f322 100644
--- a/arch/arm/configs/fortunet_defconfig
+++ b/arch/arm/configs/fortunet_defconfig
@@ -132,8 +132,7 @@ CONFIG_CMDLINE=""
 #
 # At least one emulation must be selected
 #
-# CONFIG_FPE_NWFPE is not set
-CONFIG_FPE_FASTFPE=y
+CONFIG_FPE_NWFPE=y
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 1502957..838e639 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -178,7 +178,6 @@ CONFIG_CPU_FREQ_SA1100=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/h5000_defconfig b/arch/arm/configs/h5000_defconfig
index 649baa3..bc74d48 100644
--- a/arch/arm/configs/h5000_defconfig
+++ b/arch/arm/configs/h5000_defconfig
@@ -285,7 +285,6 @@ CONFIG_ATAGS_PROC=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/h7201_defconfig b/arch/arm/configs/h7201_defconfig
index 116920a..419f078 100644
--- a/arch/arm/configs/h7201_defconfig
+++ b/arch/arm/configs/h7201_defconfig
@@ -133,7 +133,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/h7202_defconfig b/arch/arm/configs/h7202_defconfig
index 0e739af..02db75f 100644
--- a/arch/arm/configs/h7202_defconfig
+++ b/arch/arm/configs/h7202_defconfig
@@ -137,7 +137,6 @@ CONFIG_CMDLINE="console=ttyS0,19200"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index db0708d..e662f63 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -171,7 +171,6 @@ CONFIG_CPU_FREQ_SA1100=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 3ce96e6..9b92a5d 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -176,7 +176,6 @@ CONFIG_CPU_FREQ_INTEGRATOR=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/iop13xx_defconfig b/arch/arm/configs/iop13xx_defconfig
index 89c1776..92f3cd5 100644
--- a/arch/arm/configs/iop13xx_defconfig
+++ b/arch/arm/configs/iop13xx_defconfig
@@ -233,7 +233,6 @@ CONFIG_CMDLINE="ip=bootp root=nfs console=ttyS0,115200 nfsroot=,tcp,v3,wsize=819
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index d70177b..e81550e 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -237,7 +237,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp cachepolicy=writeall
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/iop33x_defconfig b/arch/arm/configs/iop33x_defconfig
index eec4882..7439cb6 100644
--- a/arch/arm/configs/iop33x_defconfig
+++ b/arch/arm/configs/iop33x_defconfig
@@ -233,7 +233,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp cachepolicy=writeall
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ixp2000_defconfig b/arch/arm/configs/ixp2000_defconfig
index 57526c1..1dbae8b 100644
--- a/arch/arm/configs/ixp2000_defconfig
+++ b/arch/arm/configs/ixp2000_defconfig
@@ -215,7 +215,6 @@ CONFIG_CMDLINE="console=ttyS0,57600 root=/dev/nfs ip=bootp mem=64M at 0x0"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ixp23xx_defconfig b/arch/arm/configs/ixp23xx_defconfig
index ef97561..f028958 100644
--- a/arch/arm/configs/ixp23xx_defconfig
+++ b/arch/arm/configs/ixp23xx_defconfig
@@ -211,7 +211,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 95cd8df..0853273 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -263,7 +263,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 ip=bootp root=/dev/nfs"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index df9bfbe..50c394c 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -304,7 +304,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/kafa_defconfig b/arch/arm/configs/kafa_defconfig
index 9f92fc5..19765a0 100644
--- a/arch/arm/configs/kafa_defconfig
+++ b/arch/arm/configs/kafa_defconfig
@@ -195,7 +195,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20800000,10M root=/dev/ram
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/kb9202_defconfig b/arch/arm/configs/kb9202_defconfig
index 605a846..3ce924a 100644
--- a/arch/arm/configs/kb9202_defconfig
+++ b/arch/arm/configs/kb9202_defconfig
@@ -319,7 +319,6 @@ CONFIG_ATAGS_PROC=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/ks8695_defconfig b/arch/arm/configs/ks8695_defconfig
index d25c41b..d09fbb0 100644
--- a/arch/arm/configs/ks8695_defconfig
+++ b/arch/arm/configs/ks8695_defconfig
@@ -279,7 +279,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x20410000,3145728 root=/dev
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 56ae568..d1d462f 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -165,7 +165,6 @@ CONFIG_CPU_FREQ_SA1100=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/loki_defconfig b/arch/arm/configs/loki_defconfig
index b720fcf..612fc65 100644
--- a/arch/arm/configs/loki_defconfig
+++ b/arch/arm/configs/loki_defconfig
@@ -246,7 +246,6 @@ CONFIG_CMDLINE=""
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index 1a38d8e..d705c9d 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -204,7 +204,6 @@ CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/lpd7a400_defconfig b/arch/arm/configs/lpd7a400_defconfig
index f8ac29d..767ee5a 100644
--- a/arch/arm/configs/lpd7a400_defconfig
+++ b/arch/arm/configs/lpd7a400_defconfig
@@ -148,7 +148,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/lpd7a404_defconfig b/arch/arm/configs/lpd7a404_defconfig
index 7a2e932..2c66261 100644
--- a/arch/arm/configs/lpd7a404_defconfig
+++ b/arch/arm/configs/lpd7a404_defconfig
@@ -178,7 +178,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index e544bfb..6faa3bd 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -152,7 +152,6 @@ CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/lusl7200_defconfig b/arch/arm/configs/lusl7200_defconfig
index 42f6a77..b2ee97a 100644
--- a/arch/arm/configs/lusl7200_defconfig
+++ b/arch/arm/configs/lusl7200_defconfig
@@ -127,7 +127,6 @@ CONFIG_CMDLINE="console=tty0 console=ttyLU1,115200 root=/dev/ram initrd=0xf10000
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 957fd5f..cbcfb5f 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -302,7 +302,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index cc8c95b..3ca6304 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -142,7 +142,6 @@ CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 398274b..30c2e4d 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -274,7 +274,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/mx1_defconfig b/arch/arm/configs/mx1_defconfig
index 0200d67..7a918e6 100644
--- a/arch/arm/configs/mx1_defconfig
+++ b/arch/arm/configs/mx1_defconfig
@@ -275,7 +275,6 @@ CONFIG_CMDLINE="noinitrd console=ttymxc0,115200 root=/dev/mtdblock2 rw ip=off"
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/mx1ads_defconfig b/arch/arm/configs/mx1ads_defconfig
index 577d7e1..fba349f 100644
--- a/arch/arm/configs/mx1ads_defconfig
+++ b/arch/arm/configs/mx1ads_defconfig
@@ -139,7 +139,6 @@ CONFIG_CMDLINE="console=ttySMX0,57600n8 ip=bootp root=/dev/nfs"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-CONFIG_FPE_FASTFPE=y
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/mx21_defconfig b/arch/arm/configs/mx21_defconfig
index 4b04290..2ea49d5 100644
--- a/arch/arm/configs/mx21_defconfig
+++ b/arch/arm/configs/mx21_defconfig
@@ -271,7 +271,6 @@ CONFIG_CMDLINE=""
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index 75263a8..60cdc01 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -293,7 +293,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index a4f9a2a..3122e9c 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -303,7 +303,6 @@ CONFIG_CMDLINE="noinitrd console=ttymxc0,115200 root=/dev/mtdblock2 rw ip=off"
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/n770_defconfig b/arch/arm/configs/n770_defconfig
index a1657b7..a68fab0 100644
--- a/arch/arm/configs/n770_defconfig
+++ b/arch/arm/configs/n770_defconfig
@@ -288,7 +288,6 @@ CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 time"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index 8da75de..3eac4d3 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -323,7 +323,6 @@ CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS0,115200n8"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/neocore926_defconfig b/arch/arm/configs/neocore926_defconfig
index e0e4e98..6294555 100644
--- a/arch/arm/configs/neocore926_defconfig
+++ b/arch/arm/configs/neocore926_defconfig
@@ -292,7 +292,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 36cd62e..e3be152 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -175,7 +175,6 @@ CONFIG_CPU_FREQ_SA1110=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index c1a63a3..8049345 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -142,7 +142,6 @@ CONFIG_CMDLINE="root=0x301"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/netx_defconfig b/arch/arm/configs/netx_defconfig
index 61d0fc5..082cdcc 100644
--- a/arch/arm/configs/netx_defconfig
+++ b/arch/arm/configs/netx_defconfig
@@ -183,7 +183,6 @@ CONFIG_CMDLINE="console=ttySMX0,115200"
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 600cb27..7217f7e 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -281,7 +281,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 357d402..55c39b7 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -304,7 +304,6 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.16
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
 # CONFIG_NEON is not set
diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index d5ff477..adec3c2 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -316,7 +316,6 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.16
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
 CONFIG_NEON=y
diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index b54ad2e..f8726c0 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -300,7 +300,6 @@ CONFIG_CMDLINE=" debug "
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
 CONFIG_NEON=y
diff --git a/arch/arm/configs/omap_2430sdp_defconfig b/arch/arm/configs/omap_2430sdp_defconfig
index 640e9af..d91e528 100644
--- a/arch/arm/configs/omap_2430sdp_defconfig
+++ b/arch/arm/configs/omap_2430sdp_defconfig
@@ -280,7 +280,6 @@ CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ra
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_apollon_2420_defconfig b/arch/arm/configs/omap_apollon_2420_defconfig
index ac7adf3..763a56a 100644
--- a/arch/arm/configs/omap_apollon_2420_defconfig
+++ b/arch/arm/configs/omap_apollon_2420_defconfig
@@ -277,7 +277,6 @@ CONFIG_CMDLINE="root=/dev/ram0 rw mem=128M console=ttyS0,115200n8 initrd=0x80600
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/omap_generic_1510_defconfig b/arch/arm/configs/omap_generic_1510_defconfig
index ccdc661..320e504 100644
--- a/arch/arm/configs/omap_generic_1510_defconfig
+++ b/arch/arm/configs/omap_generic_1510_defconfig
@@ -285,7 +285,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS2,115200 root=0803 ro init=/bin/sh"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/omap_generic_1610_defconfig b/arch/arm/configs/omap_generic_1610_defconfig
index 0c42c89..a0ed642 100644
--- a/arch/arm/configs/omap_generic_1610_defconfig
+++ b/arch/arm/configs/omap_generic_1610_defconfig
@@ -287,7 +287,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS2,115200 root=0803 ro init=/bin/sh"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_generic_1710_defconfig b/arch/arm/configs/omap_generic_1710_defconfig
index 0a00a70..39063c9 100644
--- a/arch/arm/configs/omap_generic_1710_defconfig
+++ b/arch/arm/configs/omap_generic_1710_defconfig
@@ -281,7 +281,6 @@ CONFIG_CMDLINE="mem=64M console=tty0 console=ttyS2,115200 root=0801"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_generic_2420_defconfig b/arch/arm/configs/omap_generic_2420_defconfig
index cf4073b..e3adaf4 100644
--- a/arch/arm/configs/omap_generic_2420_defconfig
+++ b/arch/arm/configs/omap_generic_2420_defconfig
@@ -274,7 +274,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 74dbdc6..f33b2d4 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -311,7 +311,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200n8 root=/dev/ram0 rw initrd=0x106000
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_h4_2420_defconfig b/arch/arm/configs/omap_h4_2420_defconfig
index a4aab8e..aa94eac 100644
--- a/arch/arm/configs/omap_h4_2420_defconfig
+++ b/arch/arm/configs/omap_h4_2420_defconfig
@@ -284,7 +284,6 @@ CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ra
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_innovator_1510_defconfig b/arch/arm/configs/omap_innovator_1510_defconfig
index 0cfe363..a925306 100644
--- a/arch/arm/configs/omap_innovator_1510_defconfig
+++ b/arch/arm/configs/omap_innovator_1510_defconfig
@@ -285,7 +285,6 @@ CONFIG_CMDLINE="console=ttyS0,115200n8 root=/dev/nfs ip=bootp noinitrd"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/omap_innovator_1610_defconfig b/arch/arm/configs/omap_innovator_1610_defconfig
index 95d9f2b..2df8f13 100644
--- a/arch/arm/configs/omap_innovator_1610_defconfig
+++ b/arch/arm/configs/omap_innovator_1610_defconfig
@@ -286,7 +286,6 @@ CONFIG_CMDLINE="mem=32M console=tty0 console=ttyS0,115200 initrd=0x10200000,8M r
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index b9c4891..93d240f 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -299,7 +299,6 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.16
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
 # CONFIG_NEON is not set
diff --git a/arch/arm/configs/omap_osk_5912_defconfig b/arch/arm/configs/omap_osk_5912_defconfig
index 6b3b5c6..36ec56b 100644
--- a/arch/arm/configs/omap_osk_5912_defconfig
+++ b/arch/arm/configs/omap_osk_5912_defconfig
@@ -299,7 +299,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 initrd=0x10400000,8M root=/dev/ram0
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_perseus2_730_defconfig b/arch/arm/configs/omap_perseus2_730_defconfig
index b94800c..2a21779 100644
--- a/arch/arm/configs/omap_perseus2_730_defconfig
+++ b/arch/arm/configs/omap_perseus2_730_defconfig
@@ -280,7 +280,6 @@ CONFIG_CMDLINE="mem=32M console=ttyS0,115200 ip=dhcp"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index f1739fa..525e460 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -317,7 +317,6 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.16
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
 # CONFIG_NEON is not set
diff --git a/arch/arm/configs/onearm_defconfig b/arch/arm/configs/onearm_defconfig
index f8701fa..8f6665b 100644
--- a/arch/arm/configs/onearm_defconfig
+++ b/arch/arm/configs/onearm_defconfig
@@ -236,7 +236,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp mem=64M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 9e23852..1d39de9 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -289,7 +289,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/palmte_defconfig b/arch/arm/configs/palmte_defconfig
index 40fc6a7..99926d5 100644
--- a/arch/arm/configs/palmte_defconfig
+++ b/arch/arm/configs/palmte_defconfig
@@ -272,7 +272,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/palmtt_defconfig b/arch/arm/configs/palmtt_defconfig
index e54ced4..2245518 100644
--- a/arch/arm/configs/palmtt_defconfig
+++ b/arch/arm/configs/palmtt_defconfig
@@ -246,7 +246,6 @@ CONFIG_CMDLINE="root=/dev/mmcblk0p2 rw init=/init"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/palmz71_defconfig b/arch/arm/configs/palmz71_defconfig
index 08e1406..8fd3e14 100644
--- a/arch/arm/configs/palmz71_defconfig
+++ b/arch/arm/configs/palmz71_defconfig
@@ -276,7 +276,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index a0dc37c..fd85811 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -286,7 +286,6 @@ CONFIG_CMDLINE="mem=32M console=tty root=/dev/mmcblk0"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/picotux200_defconfig b/arch/arm/configs/picotux200_defconfig
index 9018f0f..eeeb69c 100644
--- a/arch/arm/configs/picotux200_defconfig
+++ b/arch/arm/configs/picotux200_defconfig
@@ -236,7 +236,6 @@ CONFIG_KEXEC=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
index f2d2dda..a69d505 100644
--- a/arch/arm/configs/pleb_defconfig
+++ b/arch/arm/configs/pleb_defconfig
@@ -164,7 +164,6 @@ CONFIG_CPU_FREQ_SA1100=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/pnx4008_defconfig b/arch/arm/configs/pnx4008_defconfig
index 67b5f1e..a66182e 100644
--- a/arch/arm/configs/pnx4008_defconfig
+++ b/arch/arm/configs/pnx4008_defconfig
@@ -182,7 +182,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index db5faea..93bbf28 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -268,7 +268,6 @@ CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index 46e5089..2a952ee 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -141,7 +141,6 @@ CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 733b851..cda2f90 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -328,7 +328,6 @@ CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 8c7e299..8727564 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -268,7 +268,6 @@ CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/qil-a9260_defconfig b/arch/arm/configs/qil-a9260_defconfig
index 9b32d0e..b0472ed 100644
--- a/arch/arm/configs/qil-a9260_defconfig
+++ b/arch/arm/configs/qil-a9260_defconfig
@@ -268,7 +268,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS1,115200"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/realview-smp_defconfig b/arch/arm/configs/realview-smp_defconfig
index 21db4b3..82ea318 100644
--- a/arch/arm/configs/realview-smp_defconfig
+++ b/arch/arm/configs/realview-smp_defconfig
@@ -281,7 +281,6 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=10.1.69.3:/work/nfsroot ip=dhcp console=tt
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 9a75c30..d7546f6 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -275,7 +275,6 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=10.1.69.3:/work/nfsroot ip=dhcp console=tt
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index b498104..2b45778 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -363,7 +363,6 @@ CONFIG_CMDLINE="root=/dev/hda1 ro init=/bin/bash console=ttySAC0"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 3286060..e4ff2bb 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -274,7 +274,6 @@ CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/bin/bash initrd=0x510
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/s5pc100_defconfig b/arch/arm/configs/s5pc100_defconfig
index b0d7d3d..613d3a2 100644
--- a/arch/arm/configs/s5pc100_defconfig
+++ b/arch/arm/configs/s5pc100_defconfig
@@ -291,7 +291,6 @@ CONFIG_CMDLINE="root=/dev/mtdblock2 rootfstype=cramfs init=/linuxrc console=ttyS
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/sam9_l9260_defconfig b/arch/arm/configs/sam9_l9260_defconfig
index 1174e27..7a6845d 100644
--- a/arch/arm/configs/sam9_l9260_defconfig
+++ b/arch/arm/configs/sam9_l9260_defconfig
@@ -249,7 +249,6 @@ CONFIG_CMDLINE="console=ttyS0,115200 mem=64M initrd=0x21100000,4194304 root=/dev
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index 984f709..6a4ea9a 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -161,7 +161,6 @@ CONFIG_CMDLINE="console=ttySA0,9600 console=tty1 root=/dev/mtdblock2 init=/linux
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/shark_defconfig b/arch/arm/configs/shark_defconfig
index 90235bf..4dd2f6e 100644
--- a/arch/arm/configs/shark_defconfig
+++ b/arch/arm/configs/shark_defconfig
@@ -261,7 +261,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index 685d2b5..b3e65d0 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -165,7 +165,6 @@ CONFIG_CMDLINE="mtdparts=sa1100:512k(boot),1m(kernel),-(root) console=ttySA0 roo
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 745c68f..867080e 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -305,7 +305,6 @@ CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/stmp378x_defconfig b/arch/arm/configs/stmp378x_defconfig
index 44461f1..ceb7d5d 100644
--- a/arch/arm/configs/stmp378x_defconfig
+++ b/arch/arm/configs/stmp378x_defconfig
@@ -280,7 +280,6 @@ CONFIG_CMDLINE="console=ttySDBG0,115200 mem=32M"
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/stmp37xx_defconfig b/arch/arm/configs/stmp37xx_defconfig
index 401279d..939952b 100644
--- a/arch/arm/configs/stmp37xx_defconfig
+++ b/arch/arm/configs/stmp37xx_defconfig
@@ -265,7 +265,6 @@ CONFIG_CMDLINE="console=ttySDBG0,115200 mem=32M lcd_panel=lms350 rdinit=/bin/sh
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/sx1_defconfig b/arch/arm/configs/sx1_defconfig
index 25b007f..ea09f87 100644
--- a/arch/arm/configs/sx1_defconfig
+++ b/arch/arm/configs/sx1_defconfig
@@ -286,7 +286,6 @@ CONFIG_CMDLINE=""
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 9d32fae..c6fa9da 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -283,7 +283,6 @@ CONFIG_CMDLINE="mem=64M root=/dev/ram0 init=/linuxrc rw"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index b6f8381..20367b7 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -233,7 +233,6 @@ CONFIG_CMDLINE="root=fe01 console=ttyS0,38400n8 loglevel=5"
 #
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 7d61ae6..0b655ff 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -294,7 +294,6 @@ CONFIG_CPU_IDLE_GOV_MENU=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/usb-a9260_defconfig b/arch/arm/configs/usb-a9260_defconfig
index fd77740..09106e0 100644
--- a/arch/arm/configs/usb-a9260_defconfig
+++ b/arch/arm/configs/usb-a9260_defconfig
@@ -268,7 +268,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/usb-a9263_defconfig b/arch/arm/configs/usb-a9263_defconfig
index e7c19dd..6a904fa 100644
--- a/arch/arm/configs/usb-a9263_defconfig
+++ b/arch/arm/configs/usb-a9263_defconfig
@@ -260,7 +260,6 @@ CONFIG_CMDLINE="mem=64M console=ttyS0,115200"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index b11c5da..abece65 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -184,7 +184,6 @@ CONFIG_CMDLINE="root=1f03 mem=32M"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 
 #
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 6ab5dd5..d7b1943 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -307,7 +307,6 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 # At least one emulation must be selected
 #
 # CONFIG_FPE_NWFPE is not set
-CONFIG_FPE_FASTFPE=y
 
 #
 # Userspace binary formats
diff --git a/arch/arm/configs/w90p910_defconfig b/arch/arm/configs/w90p910_defconfig
index 5245655..c894bc2 100644
--- a/arch/arm/configs/w90p910_defconfig
+++ b/arch/arm/configs/w90p910_defconfig
@@ -264,7 +264,6 @@ CONFIG_ATAGS_PROC=y
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 # CONFIG_VFP is not set
 
 #
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
index 33bb725..2f6c543 100644
--- a/arch/arm/configs/xcep_defconfig
+++ b/arch/arm/configs/xcep_defconfig
@@ -293,7 +293,6 @@ CONFIG_CMDLINE="root=mtd4 rootfstype=jffs2 ro console=ttyS0,115200"
 #
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
 
 #
 # Userspace binary formats
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..1432d35 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -51,7 +51,7 @@
 #define MEM_SIZE	(16*1024*1024)
 #endif
 
-#if defined(CONFIG_FPE_NWFPE) || defined(CONFIG_FPE_FASTFPE)
+#if defined(CONFIG_FPE_NWFPE)
 char fpe_type[8];
 
 static int __init fpe_setup(char *line)
-- 
1.6.3.2
