From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jul 2015 08:39:42 +0200
Subject: [PATCH v2 1/3] ARM: multi_v7_defconfig: Enable max77802 regulator
In-Reply-To: <1437028784-22189-1-git-send-email-javier@osg.samsung.com>
References: <1437028784-22189-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1437028784-22189-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 based Peach Pit and Exynos5800 based Peach Pi Chromebooks
use the Maxim max77802 Power Management IC (PMIC). This PMIC has besides
other devices, a set of regulators that can be controller over I2C.

Commit f3caa529c6f5 ("ARM: multi_v7_defconfig: Enable max77802 regulator,
rtc and clock drivers") was supposed to enable the config option for the
regulator driver as a module but the final version that landed did not
include this. The commit was modified and the REGULATOR_MAX77802 removed
since it was thought to be useless.

Unfortunately that's not the case for the mentioned reason above so this
patch enables the needed Kconfig option.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes in v2:
- Better explanation why the max77802 regulator config option is needed.
- Add Krzysztof Kozlowski Reviewed-by tag in patch #1

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4b93761d58d2..b07493997993 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -402,6 +402,7 @@ CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
+CONFIG_REGULATOR_MAX77802=m
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_S2MPS11=y
-- 
2.4.3
