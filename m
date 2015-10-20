From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 14:54:44 +0530
Subject: [PATCH v2 5/6] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1445333085-22837-6-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we switch to use generic syscon regmap based reset/poweroff
driver for exynos SoC, lets select it from ARCH_EXYNOS instead of
enabling it from various defconfigs. This also select POWER_RESET
as SYSCON-{reset, poweroff} drivers depends on it.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---

Have run make for allyes, allmod, multi_v7 and exynos defconfigs
no error/warrning reported.

 arch/arm/mach-exynos/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 3a10f1a8317a..d279edf9b10d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -27,6 +27,9 @@ menuconfig ARCH_EXYNOS
 	select SRAM
 	select THERMAL
 	select MFD_SYSCON
+	select POWER_RESET
+	select POWER_RESET_SYSCON
+	select POWER_RESET_SYSCON_POWEROFF
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
-- 
1.7.10.4
