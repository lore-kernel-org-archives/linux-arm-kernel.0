From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 15 Mar 2013 16:38:59 +0000
Subject: [PATCH 1/2] ARM: vexpress: Enable regulator framework when MMCI is in
 use
In-Reply-To: <1363365540-23001-1-git-send-email-pawel.moll@arm.com>
References: <1363365540-23001-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1363365540-23001-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the MMCI driver obtains some of the platform data from
a regulator (described by the device tree), the framework must
be present - otherwise device's initialisation will fail.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 52d315b..46ab88d 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -17,6 +17,7 @@ config ARCH_VEXPRESS
 	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select VEXPRESS_CONFIG
 	help
-- 
1.7.10.4
