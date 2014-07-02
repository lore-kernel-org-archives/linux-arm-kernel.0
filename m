From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 02 Jul 2014 17:40:58 +0200
Subject: [PATCH 0/6] Various improvements for samsung-pinctrl driver
Message-ID: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes various shortcommings of the Samsung pin control driver
that have been spotted while using it on various platforms with multiple
use cases and requirements.

Most of the patches are independent of each other, with the exception of
patch 4/6 which depends on patch 3/6, due to consolidation of IRQ chips.

Please see individual patches for more details.

Tested on Exynos4412-based Trats2 board with display, camera and GPIO keys
enabled.

Tomasz Figa (6):
  pinctrl: samsung: Decouple direction setting from pinctrl
  pinctrl: samsung: Handle GPIO request and free using pinctrl helpers
  pinctrl: exynos: Consolidate irq_chips of GPIO and WKUP EINTs
  pinctrl: exynos: Lock GPIOs as interrupts when used as EINTs
  pinctrl: samsung: Allow grouping multiple pinmux/pinconf nodes
  pinctrl: samsung: Allow pin value to be initialized using pinfunc

 .../bindings/pinctrl/samsung-pinctrl.txt           |  24 +-
 drivers/pinctrl/pinctrl-exynos.c                   | 376 ++++-------
 drivers/pinctrl/pinctrl-samsung.c                  | 728 ++++++++++++---------
 drivers/pinctrl/pinctrl-samsung.h                  |  19 +-
 4 files changed, 568 insertions(+), 579 deletions(-)

-- 
1.9.3
