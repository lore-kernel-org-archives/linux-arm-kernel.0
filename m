From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Dec 2015 15:19:02 +0100
Subject: [PATCH 0/4] Use new MSI infrastructure on Marvell EBU
Message-ID: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

IMPORTANT: do not apply the following set of patches now. They depend
on two irqdomain fixes from Marc Zyngier, which he hasn't submitted
yet. So this patch series is currently for review.

(In fact patches 1 and 4 and be applied now, but patches 2 and 3 will
have to wait until Marc submits his patches.)

For those interested, the two fixes needed are available at
https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqdomain-fixes.

This patch series converts the Armada 370/XP irqchip driver (also used
on Armada 375, 38x and 39x) to the new MSI infrastructure put in place
by Marc. It doesn't bring any functional difference other than using
the right, modern, MSI mechanism, which might ultimately allow Marc to
remove the old way of implementing MSI support.

It has been tested on Armada 38x and Armada XP with an Intel e1000e
NIC which uses MSI.

Thanks,

Thomas

Thomas Petazzoni (4):
  irqchip: irq-armada-370-xp: add Kconfig option for the driver
  irqchip: irq-armada-370-xp: use the generic MSI infrastructure
  irqchip: irq-armada-370-xp: use shorter names for irq_chip
  ARM: mvebu: use the ARMADA_370_XP_IRQ option

 arch/arm/mach-mvebu/Kconfig         |   6 +-
 drivers/irqchip/Kconfig             |   6 ++
 drivers/irqchip/Makefile            |   2 +-
 drivers/irqchip/irq-armada-370-xp.c | 153 +++++++++++++++---------------------
 4 files changed, 77 insertions(+), 90 deletions(-)

-- 
2.6.4
