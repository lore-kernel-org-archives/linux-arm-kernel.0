From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 18:19:00 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.11
Message-ID: <20130830011900.GA1752@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 30ca2226bea6f0db519dc53381b893cd66cb5b66:

  ARM: tegra: always enable USB VBUS regulators (2013-08-21 21:36:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to f8ab658b5da3fd11893cad085e0e21b67987c10b:

  arm: prima2: drop nr_irqs in mach as we moved to linear irqdomain (2013-08-29 09:48:36 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 3.11

Two straggling fixes that I had missed as they were posted a couple of
weeks ago, causing problems with interrupts (breaking them completely)
on the CSR SiRF platforms.

----------------------------------------------------------------
Barry Song (2):
      irqchip: sirf: move from legacy mode to linear irqdomain
      arm: prima2: drop nr_irqs in mach as we moved to linear irqdomain

 arch/arm/mach-prima2/common.c |  2 --
 drivers/irqchip/irq-sirfsoc.c | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)
