From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 23 Jul 2010 14:56:39 +0200
Subject: [PATCH 2/3] Fix KConfig warning
In-Reply-To: <1279889800-12426-1-git-send-email-eric@eukrea.com>
References: <1279889800-12426-1-git-send-email-eric@eukrea.com>
Message-ID: <1279889800-12426-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following Kconfig warning :
"arch/arm/mach-mx25/Kconfig:18:warning: choice value used outside its
choice group

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/Kconfig  |    4 ++--
 arch/arm/mach-mx25/Makefile |    2 +-
 arch/arm/mach-mx3/Kconfig   |    4 ++--
 arch/arm/mach-mx3/Makefile  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 67e0b54..c71a7bc 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -17,9 +17,9 @@ config MACH_EUKREA_CPUIMX25
 choice
 	prompt "Baseboard"
 	depends on MACH_EUKREA_CPUIMX25
-	default MACH_EUKREA_MBIMXSD_BASEBOARD
+	default MACH_EUKREA_MBIMXSD25_BASEBOARD
 
-config MACH_EUKREA_MBIMXSD_BASEBOARD
+config MACH_EUKREA_MBIMXSD25_BASEBOARD
 	prompt "Eukrea MBIMXSD development board"
 	bool
 	help
diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index 87ffb9c..d9e46ce 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -2,4 +2,4 @@ obj-y				:= mm.o devices.o
 obj-$(CONFIG_ARCH_MX25)		+= clock.o
 obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index e063657..b73a9fd 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -166,9 +166,9 @@ config MACH_EUKREA_CPUIMX35
 choice
 	prompt "Baseboard"
 	depends on MACH_EUKREA_CPUIMX35
-	default MACH_EUKREA_MBIMXSD_BASEBOARD
+	default MACH_EUKREA_MBIMXSD35_BASEBOARD
 
-config MACH_EUKREA_MBIMXSD_BASEBOARD
+config MACH_EUKREA_MBIMXSD35_BASEBOARD
 	prompt "Eukrea MBIMXSD development board"
 	bool
 	help
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 54bc935..2bd7bec 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -25,4 +25,4 @@ obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
-- 
1.6.3.3
