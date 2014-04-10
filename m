From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 15:01:29 +0200
Subject: [PATCH 0/3] mmc: mmci: Improve system PM support
Message-ID: <1397134892-20840-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables mmci to put the device into low power state at system
suspend. Previously the device was always left in full power state.

Do note, these patches were sent during the previous kernel release cycle, as
a part of another patchset on the PM core. Back then, they provided proof of
concept, for the new runtime PM helper functions:
pm_runtime_force_suspend|resume().


Ulf Hansson (3):
  mmc: mmci: Mask IRQs for all variants during runtime suspend
  mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
  mmc: mmci: Put the device into low power state at system suspend

 drivers/mmc/host/mmci.c |   60 ++++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 45 deletions(-)

-- 
1.7.9.5
