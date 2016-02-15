From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Feb 2016 09:34:06 +0900
Subject: [GIT PULL 7/7] ARM: EXYNOS: Defconfig changes for v4.6
In-Reply-To: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455496446-23779-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Defconfig changes, pulling also a tag from RTC tree (merge
of max77802 into max77686 RTC driver).

Kind regards,
Krzysztof


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.6

for you to fetch changes up to 5d51f1dde207f2d5d43158da75c6608f7bfcec03:

  ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol (2016-02-05 09:11:32 +0900)

----------------------------------------------------------------
Defconfig (exynos and multi_v7) changes for Exynos based boards for v4.6:
1. exynos defconfig:
   a. Enable NEON and accelerated crypto,
   b. Enable s5p-secss driver (Security SubSystem block for accelerating
      some cryptographic operations),
2. exynos and multi_v7: Remove MAX77802 RTC Kconfig because the driver
   was combined into existing rtc-max77686 driver. This depends on changes
   from RTC tree.

----------------------------------------------------------------
Javier Martinez Canillas (10):
      rtc: max77686: Fix max77686_rtc_read_alarm() return value
      rtc: max77686: Use ARRAY_SIZE() instead of current array length
      rtc: max77686: Use usleep_range() instead of msleep()
      rtc: max77686: Use a driver data struct instead hard-coded values
      rtc: max77686: Add an indirection level to access RTC registers
      rtc: max77686: Add max77802 support
      rtc: max77686: Fix unsupported year message
      rtc: Remove Maxim 77802 driver
      ARM: exynos_defconfig: Remove MAX77802 RTC Kconfig symbol
      ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol

Krzysztof Kozlowski (5):
      ARM: exynos_defconfig: Enable NEON, accelerated crypto and cpufreq stats
      ARM: exynos_defconfig: Enable s5p-secss driver
      rtc: max77686: Properly handle regmap_irq_get_virq() error code
      rtc: max77686: Cleanup and reduce dmesg output
      Merge tag 'rtc-max77686-4.6' of git://git.kernel.org/.../abelloni/linux into next/defconfig

 arch/arm/configs/exynos_defconfig   |  10 +-
 arch/arm/configs/multi_v7_defconfig |   1 -
 drivers/rtc/Kconfig                 |  10 -
 drivers/rtc/Makefile                |   1 -
 drivers/rtc/rtc-max77686.c          | 362 ++++++++++++++++++++------
 drivers/rtc/rtc-max77802.c          | 502 ------------------------------------
 6 files changed, 285 insertions(+), 601 deletions(-)
 delete mode 100644 drivers/rtc/rtc-max77802.c
