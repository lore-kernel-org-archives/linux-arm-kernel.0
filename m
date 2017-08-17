From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Aug 2017 10:50:49 -0700
Subject: [GIT PULL] non-urgent fixes for omaps for v4.14
Message-ID: <pull-1502992204-718163>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:

  ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-not-urgent-v2-signed

for you to fetch changes up to 879dce79531ea82f78d662c4651be07761c6e41a:

  ARM: OMAP4+: PRM: fix of_irq_get() result checks (2017-08-15 08:53:28 -0700)

----------------------------------------------------------------
Non-urgent fixes for omaps for v4.14 merge window. These all
can wait for the merge window as we have not seemed to hit
any of these so far:

- Fix error handling in omap_ocp2scp_probe affecting runtime
  PM error path

- Drop broken RPM status update for omap_device

- Two fixes for of_irq_get() usage that can return 0

----------------------------------------------------------------
Johan Hovold (1):
      ARM: OMAP2+: omap_device: drop broken RPM status update from suspend_noirq

Kishon Vijay Abraham I (1):
      bus: omap-ocp2scp: Fix error handling in omap_ocp2scp_probe

Sergei Shtylyov (2):
      ARM: OMAP3+: PRM: fix of_irq_get() result check
      ARM: OMAP4+: PRM: fix of_irq_get() result checks

 arch/arm/mach-omap2/omap_device.c | 10 ----------
 arch/arm/mach-omap2/prm3xxx.c     |  2 +-
 arch/arm/mach-omap2/prm44xx.c     |  4 ++--
 drivers/bus/omap-ocp2scp.c        |  9 +++++++--
 4 files changed, 10 insertions(+), 15 deletions(-)
