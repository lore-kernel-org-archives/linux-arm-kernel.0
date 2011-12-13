From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 13 Dec 2011 07:31:43 +0100
Subject: [PATCH 11/19] cpuimx35sd: fix Kconfig
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <1323757911-25217-11-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in 0d6cfa3a75f5cde5b3ca0dde748fd22625b4f34c I fixed the mach-types
records. We also need to make the name consistent in Kconfig else
the machine_is_eukrea_cpuimx35sd macro fails, and thus audio codec
is not properly initalized.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig  |    4 ++--
 arch/arm/mach-imx/Makefile |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 388dd5a..3000583 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -544,7 +544,7 @@ config MACH_MX35_3DS
 	  Include support for MX35PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
-config MACH_EUKREA_CPUIMX35
+config MACH_EUKREA_CPUIMX35SD
 	bool "Support Eukrea CPUIMX35 Platform"
 	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FLEXCAN
@@ -562,7 +562,7 @@ config MACH_EUKREA_CPUIMX35
 
 choice
 	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX35
+	depends on MACH_EUKREA_CPUIMX35SD
 	default MACH_EUKREA_MBIMXSD35_BASEBOARD
 
 config MACH_EUKREA_MBIMXSD35_BASEBOARD
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 646f643..d97f409 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_MACH_BUG) += mach-bug.o
 # i.MX35 based machines
 obj-$(CONFIG_MACH_PCM043) += mach-pcm043.o
 obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
-obj-$(CONFIG_MACH_EUKREA_CPUIMX35) += mach-cpuimx35.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX35SD) += mach-cpuimx35.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
 obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
 
-- 
1.7.6.4
