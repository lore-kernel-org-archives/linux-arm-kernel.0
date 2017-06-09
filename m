From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  9 Jun 2017 18:48:27 +0200
Subject: [GIT PULL] pinctrl: samsung: Pinctrl update for v4.13
Message-ID: <20170609164827.2231-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few cleanups, code improvements and minor fixes. Description along
with a tag.

Best regards,
Krzysztof


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.13

for you to fetch changes up to a453f3693f2aa9ebba623f8cff1e3d7c5df96ddd:

  pinctrl: samsung: Explicitly cast pointer returned by of_iomap() to iomem (2017-06-07 20:40:48 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers update for v4.13:
1. Split drivers per ARMv7 and ARMv8 architectures because there
   is no need to compile everything on each of them.
2. Fix for possible NULL-pointer dereference after memory allocation
   failure.
3. Cleanups (silencing cast warnings, constify, removal of unneeded
   casts, removal of modular boiler-plate).

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      pinctrl: samsung: Add include guard to local header
      pinctrl: samsung: Split Exynos drivers per ARMv7 and ARMv8
      pinctrl: samsung: Constify wakeup driver specific data
      pinctrl: samsung: Handle memory allocation failure during wakeup banks init
      pinctrl: samsung: Explicitly cast pointer returned by of_iomap() to iomem

Masahiro Yamada (1):
      pinctrl: samsung: Remove unneeded (void *) casts in of_match_table

Paul Gortmaker (1):
      pinctrl: samsung: Clean up modular vs. non-modular distinctions

 drivers/pinctrl/samsung/Kconfig                |   10 +
 drivers/pinctrl/samsung/Makefile               |    2 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   |  815 +++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  399 ++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 1169 +-----------------------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |   13 +
 drivers/pinctrl/samsung/pinctrl-exynos5440.c   |   15 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c      |    2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c      |    2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c      |   39 +-
 10 files changed, 1269 insertions(+), 1197 deletions(-)
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm.c
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
