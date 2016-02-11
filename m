From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 10:44:18 +0000
Subject: [PULL] GIC fixes for 4.5-rc4
Message-ID: <1455187458-28775-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Please find below a pull request for a few GIC fixes that have been on
the list recently, and that I'd like to go in 4.5-rc4.

Thanks,

	M.

The following changes since commit 1a485f4d2e28efd77075b2952926683d6c245633:

  irqchip/gicv3-its: Fix memory leak in its_free_tables() (2016-02-04 15:14:50 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/gic-fixes-4.5-rc4

for you to fetch changes up to 1a1ebd5fb1e203ee8cc73508cc7a38ac4b804596:

  irqchip/gic-v3: Make sure read from ICC_IAR1_EL1 is visible on redestributor (2016-02-11 10:20:02 +0000)

----------------------------------------------------------------
GIC fixes for 4.5-rc4:

- Two fixes addressing cascaded GICv1/GICv2 (affinity setting, EOImode)
- One fix addressing possible missed interrupts on GICv3

----------------------------------------------------------------
Jon Hunter (2):
      irqchip/gic: Only populate set_affinity for the root controller
      irqchip/gic: Only set the EOImodeNS bit for the root controller

Tirumalesh Chalamarla (1):
      irqchip/gic-v3: Make sure read from ICC_IAR1_EL1 is visible on redestributor

 arch/arm64/include/asm/arch_gicv3.h |  1 +
 drivers/irqchip/irq-gic.c           | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)
