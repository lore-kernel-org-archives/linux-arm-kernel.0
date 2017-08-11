From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 11 Aug 2017 07:50:48 +0200
Subject: [GIT PULL] pinctrl: samsung: Changes for v4.14
Message-ID: <1502430648-3676-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Two fixes in this pull request were not regressions from current merge
window and one was known for some time, so I did not push them
to this cycle.

Best regards,
Krzysztof


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.14

for you to fetch changes up to bbed85f45b2b727bb776b914b84c67e8fd825433:

  pinctrl: samsung: Remove unneeded local variable initialization (2017-07-24 06:56:02 +0200)

----------------------------------------------------------------
Samsung pinctrl driver changes for v4.14:
1. Fix NULL pointer dereference on S3C24XX.  This was reported some time ago and
   unfortunately it took few releases to fix.
2. Fix invalid register offset used for external interrupts on Exynos5433.
   This was caused by the same commit as above, although on different path.
3. Consolidate between drivers and bindings the defines for pin mux functions.
4. Minor code improvements.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      pinctrl: samsung: Fix NULL pointer exception on external interrupts on S3C24xx
      pinctrl: samsung: Fix invalid register offset used for Exynos5433 external interrupts
      pinctrl: samsung: dt-bindings: Use better name for external interrupt function
      pinctrl: samsung: Use define from dt-bindings for pin mux function
      pinctrl: samsung: Use unsigned int for number of controller IO mem resources
      pinctrl: samsung: Consistently use unsigned instead of u32 for nr_banks
      pinctrl: samsung: Remove unneeded local variable initialization

 drivers/pinctrl/samsung/pinctrl-exynos.c  | 32 ++++++++++---------------
 drivers/pinctrl/samsung/pinctrl-exynos.h  |  1 -
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 37 +++++++++++++++-------------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c | 40 ++++++++++++++-----------------
 drivers/pinctrl/samsung/pinctrl-samsung.c | 12 ++++++++--
 drivers/pinctrl/samsung/pinctrl-samsung.h | 15 ++++++------
 include/dt-bindings/pinctrl/samsung.h     |  3 ++-
 7 files changed, 71 insertions(+), 69 deletions(-)
