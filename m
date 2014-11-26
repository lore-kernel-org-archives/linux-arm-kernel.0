From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Nov 2014 17:55:30 +0000
Subject: [PATCH 0/2] ARM: tegra: a couple of irq-related fixes
Message-ID: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I've started looking at getting rid of the horrible gic_arch_extn
hack by using stacked irq domains, I couldn't help but notice a couple
of nits, the first one being fairly major:

- The shadow interrupt controller is using the irq field instead of
  hwirq, which leads to fun results...
- We still have some leftovers from non-DT setups, which don't seem to
  exist anymore.

Patches are against v3.18-rc6, and have been tested on a Harmony
board.

Thanks,

	M.

Marc Zyngier (2):
  ARM: tegra: irq: fix buggy usage of irq_data irq field
  ARM: tegra: irq: nuke leftovers from non-DT support

 arch/arm/mach-tegra/irq.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.1.3
