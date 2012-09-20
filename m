From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:38 +0200
Subject: [PATCH 0/6] pinctrl: samsung: Various fixes
Message-ID: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains various fixes of problems and nitpicks spotted when
working on adding support for Exynos4x12. See each patch for more detailed
information.

TODO:
 - setting WEINT pins to EINT function in exynos_wkup_irq_set_type

Tomasz Figa (6):
  pinctrl: exynos: Set pin function to EINT in irq_set_type of GPIO
    EINT
  pinctrl: exynos: Fix typos in gpio/wkup _irq_mask
  pinctrl: exynos: Handle only unmasked wakeup interrupts
  pinctrl: exynos: Mark exynos_irq_demux_eint as inline
  pinctrl: exynos: Correct the detection of wakeup-eint node
  pinctrl: samsung: Uninline samsung_pinctrl_get_soc_data

 drivers/pinctrl/pinctrl-exynos.c  | 39 +++++++++++++++++++++++++++++----------
 drivers/pinctrl/pinctrl-exynos.h  |  1 +
 drivers/pinctrl/pinctrl-samsung.c |  2 +-
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
1.7.12
