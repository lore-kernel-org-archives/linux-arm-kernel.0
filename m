From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 11:22:44 +0900
Subject: [GIT PULL] ARM: defconfig: Exynos improvements for 4.4
Message-ID: <1443579766-15793-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Few defconfig related changes for 4.4.

Description along with a tag.
You can find them also on the lists with my reviewed-by.

Best regards,
Krzysztof


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-defconfig-4.4

for you to fetch changes up to 7fa5ce4e6fcb4596761c17e124e7d1f8cf64fe96:

  ARM: exynos_defconfig: Disable simplefb support (2015-09-13 19:25:39 +0900)

----------------------------------------------------------------
Defconfig changes around Exynos based boards:
1. Enable DWC2 USB driver for exynos and multi_v7 defconfigs.
   The driver is present on Exynos and Rockhip boards. Enabling also
   ethernet gadget allows betwork communication with the device.
2. Enable LEDS for Odroid XU3/XU4 family boards (provides simple
   monitoring of the board).
3. Disable the simplefb driver because in certain situations (when
   U-boot injects simplefb bindings into DTB) it may break display.

----------------------------------------------------------------
Anand Moon (1):
      ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4

Javier Martinez Canillas (1):
      ARM: exynos_defconfig: Disable simplefb support

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable DWC2 USB driver and USB ethernet gadget
      ARM: multi_v7_defconfig: Enable DWC2 USB driver and USB ethernet gadget

 arch/arm/configs/exynos_defconfig   | 9 ++++++++-
 arch/arm/configs/multi_v7_defconfig | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)
