From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 May 2018 17:55:47 +0200
Subject: [GIT PULL] pinctrl: samsung: Stuff for v4.18
Message-ID: <20180519155547.6678-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Few patches for next cycle.

Best regards,
Krzysztof


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.18

for you to fetch changes up to 0ca0557e3727951bdc44ea47bc6135b37f90338c:

  pinctrl: samsung: Remove support for Exynos5440 (2018-05-02 19:08:55 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v4.18

1. Driver expects specific order of GPIO interrupt banks.  For S5Pv220
   and Exynos5410 this order was not preserved so fix and document it.
2. Remove support for Exynos5440 (tree-wide, support is dropped because
   there are no real users of this platform, it also did not get testing
   since long time).

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      pinctrl: samsung: Remove support for Exynos5440

Pawe? Chmiel (2):
      pinctrl: samsung: Correct EINTG banks order
      pinctrl: samsung: Document required order of banks

 drivers/pinctrl/samsung/Kconfig                |   10 +-
 drivers/pinctrl/samsung/Makefile               |    1 -
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   |   30 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |   20 +
 drivers/pinctrl/samsung/pinctrl-exynos5440.c   | 1005 ------------------------
 5 files changed, 50 insertions(+), 1016 deletions(-)
 delete mode 100644 drivers/pinctrl/samsung/pinctrl-exynos5440.c
