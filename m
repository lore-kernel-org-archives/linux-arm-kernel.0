From: khilman@linaro.org (Kevin Hilman)
Date: Mon,  9 Sep 2013 15:42:33 -0700
Subject: [GIT PULL 1/3] ARM: SoC drivers for v3.12
In-Reply-To: <1378766555-9679-1-git-send-email-khilman@linaro.org>
References: <1378766555-9679-1-git-send-email-khilman@linaro.org>
Message-ID: <1378766555-9679-2-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains ARM SoC related driver updates for v3.12.  The
only thing this cycle are core PM updates and CPUidle support for
ARM's TC2 big.LITTLE development platform.

Conflicts:

One cleanup/reorg conflict with a new entry in
drivers/cpuidle/Makefile.  Append the new entry after the existing
ones.  A follow up patch for v3.12-rc will make the new entry conform
to the cleanup/reorg.

----------------------------------------------------------------

The following changes since commit e5c832d5558826cc6e9a24746cfdec8e7780063a:

  vfs: fix dentry RCU to refcounting possibly sleeping dput()

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/drivers-for-linus

for you to fetch changes up to 158a71f83800f07c0da0f0159d2670bdf4bdd852:

  Merge tag 'msi-3.12' of git://git.infradead.org/linux-mvebu into next/drivers

----------------------------------------------------------------

Lorenzo Pieralisi (2):
      ARM: vexpress: tc2: disable GIC CPU IF in tc2_pm_suspend
      cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver

Nicolas Pitre (1):
      drivers: irq-chip: irq-gic: introduce gic_cpu_if_down()

Olof Johansson (2):
      Merge branch 'cpuidle/biglittle' into next/drivers
      Merge tag 'msi-3.12' of git://git.infradead.org/linux-mvebu into next/drivers


 MAINTAINERS                          |   9 ++
 arch/arm/mach-vexpress/tc2_pm.c      |   2 +
 drivers/cpuidle/Kconfig              |  10 ++
 drivers/cpuidle/Makefile             |   1 +
 drivers/cpuidle/cpuidle-big_little.c | 209 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c            |   6 +
 include/linux/irqchip/arm-gic.h      |   1 +
 7 files changed, 238 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-big_little.c
