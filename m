From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 09:38:42 +0900
Subject: [GIT PULL] ARM: defconfig: Exynos improvements for 4.4, 2nd pull
Message-ID: <1444696722-25093-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

This is another round of defconfig related changes for 4.4.

Description along with a tag.
You can find them also on the lists with my reviewed-by.

Best regards,
Krzysztof


The following changes since commit 7fa5ce4e6fcb4596761c17e124e7d1f8cf64fe96:

  ARM: exynos_defconfig: Disable simplefb support (2015-09-13 19:25:39 +0900)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-defconfig-4.4-2

for you to fetch changes up to 89a0112100e74f50407d269570a02a82fd28ccb8:

  ARM: multi_v7_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4 (2015-10-12 12:59:50 +0900)

----------------------------------------------------------------
Defconfig changes around Exynos based boards:
1. Change WiFi-Ex from built-in to module to fix issue with probing
   the driver before root filesystem is available (driver needs
   firmware).
2. Enable Realtek RTL81t3 ethernet adapter present on Odroid-XU4
   board.

----------------------------------------------------------------
Anand Moon (2):
      ARM: exynos_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4
      ARM: multi_v7_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4

Javier Martinez Canillas (1):
      ARM: exynos_defconfig: Enable WiFi-Ex as a module instead built-in

 arch/arm/configs/exynos_defconfig   | 5 +++--
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
