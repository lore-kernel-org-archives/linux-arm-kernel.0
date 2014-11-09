From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun,  9 Nov 2014 23:25:50 +0900
Subject: Samsung pinctrl patches for v3.19
Message-ID: <1415543150-3493-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please consider the following pull request containing queued changes for
pinctrl-samsung driver. I'm sorry for all the delays in handling this. Things
should get better from now on, though.

Best regards,
Tomasz

-----------------------------------------------------------------

The following changes since commit 6e08d6bbebebcf70f982d7190c4b6dc456cedd57:

  pinctrl: Add Intel Cherryview/Braswell pin controller support (2014-11-04 11:21:02 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-pinctrl.git tags/for_3.19/samsung-pinctrl

for you to fetch changes up to 2891ba2906b6d2fd453042f410a11e6fc3edc37d:

  pinctrl: exynos: Add support for Exynos4415 (2014-11-09 22:28:07 +0900)

----------------------------------------------------------------
Samsung pinctrl patches for v3.19

1) pinctrl-samsung data structure clean-up

8100cf4 pinctrl: samsung: Separate per-bank init and runtime data
1bf00d7 pinctrl: samsung: Constify samsung_pin_ctrl struct
94ce944 pinctrl: samsung: Constify samsung_pin_bank_type struct
e06deff pinctrl: samsung: Drop unused label field in samsung_pin_ctrl struct
8799327 pinctrl: samsung: Make samsung_pinctrl_get_soc_data use ERR_PTR()

2) pinctrl-samsung Exynos7 support

50cea0c pinctrl: exynos: Add initial driver data for Exynos7
14c255d pinctrl: exynos: Add irq_chip instance for Exynos7 wakeup interrupts
6f5e41b pinctrl: exynos: Consolidate irq domain callbacks
0d3d30d pinctrl: exynos: Generalize the eint16_31 demux code

3) pinctrl-samsung Exynos4415 support

2891ba2 pinctrl: exynos: Add support for Exynos4415

----------------------------------------------------------------
Abhilash Kesavan (3):
      pinctrl: exynos: Generalize the eint16_31 demux code
      pinctrl: exynos: Consolidate irq domain callbacks
      pinctrl: exynos: Add irq_chip instance for Exynos7 wakeup interrupts

Naveen Krishna Ch (1):
      pinctrl: exynos: Add initial driver data for Exynos7

Tomasz Figa (6):
      pinctrl: samsung: Make samsung_pinctrl_get_soc_data use ERR_PTR()
      pinctrl: samsung: Drop unused label field in samsung_pin_ctrl struct
      pinctrl: samsung: Constify samsung_pin_bank_type struct
      pinctrl: samsung: Constify samsung_pin_ctrl struct
      pinctrl: samsung: Separate per-bank init and runtime data
      pinctrl: exynos: Add support for Exynos4415

 .../bindings/pinctrl/samsung-pinctrl.txt           |   3 +
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 376 +++++++++++++++------
 drivers/pinctrl/samsung/pinctrl-exynos.h           |   3 +
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |  30 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  31 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 131 +++----
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  82 +++--
 7 files changed, 435 insertions(+), 221 deletions(-)
