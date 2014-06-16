From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 16 Jun 2014 09:58:00 +0200
Subject: [PATCH 0/3] mmc: mmci: Restore irq handling behavior for arm_variant
Message-ID: <1402905483-22567-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "mmc: mmci: Handle CMD irq before DATA irq" introduced a bug, reported
by John Stultz while using the arm_variant in QEMU envrionment.

More information can be found here:
https://lkml.org/lkml/2014/6/12/19

In this patchset we restores the old behavior for handling irqs, but only for
the arm_variant.

Ulf Hansson (3):
  mmc: mmci: Remove redundant check of status for DATA irq
  mmc: mmci: Move all CMD irq handling to mmci_cmd_irq()
  mmc: mmci: Reverse IRQ handling for the arm_variant

 drivers/mmc/host/mmci.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
1.7.9.5
