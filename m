From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Feb 2016 13:08:51 +0000
Subject: [PULL] GICv3 changes for 4.5-rc5
Message-ID: <1455887331-29492-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Please find below a pull request for three GICv3 fixes that I've
collected over the past week. Hopefully, this will be the last batch
for 4.5.

Thanks,

	M.

The following changes since commit 1a1ebd5fb1e203ee8cc73508cc7a38ac4b804596:

  irqchip/gic-v3: Make sure read from ICC_IAR1_EL1 is visible on redestributor (2016-02-11 10:20:02 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/gic-fixes-4.5-rc5

for you to fetch changes up to 8f318526a292c5e7cebb82f3f766b83c22343293:

  irqchip/gic-v3: Add missing barrier to 32bit version of gic_read_iar() (2016-02-18 19:15:45 +0000)

----------------------------------------------------------------
GIC fixes for 4.5-rc5:

- EOI handling for LPIs when GICv3 is in EOImode==1
- Another fallout from changing page size while allocating ITS tables
- Missing memory barrier in the 32bit GICv3 code

----------------------------------------------------------------
Ashok Kumar (1):
      irqchip/gic-v3-its: Fix double ICC_EOIR write for LPI in EOImode==1

Marc Zyngier (1):
      irqchip/gic-v3: Add missing barrier to 32bit version of gic_read_iar()

Shanker Donthineni (1):
      irqchip/gicv3-its: Avoid cache flush beyond ITS_BASERn memory size

 arch/arm/include/asm/arch_gicv3.h |  1 +
 drivers/irqchip/irq-gic-v3-its.c  | 18 +++++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)
