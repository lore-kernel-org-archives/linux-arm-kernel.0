From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 Jan 2015 11:13:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v3.19
Message-ID: <cover.1421113695.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v3.19.

This pull request is based on the last round of SoC updates for v3.19,
Fourth Round of Renesas ARM Based SoC Updates for v3.19, tagged as
renesas-soc3-for-v3.19, merged into your next/soc branch and included in
v3.19-rc1.


* ARM: shmobile: r8a7740: Instantiate GIC from C board code in legacy builds

  This fixes a long standing problem which has been present since
  the sh73a0 SoC started using the INTC External IRQ pin driver.

  The patch that introduced the problem is 341eb5465f67437a ("ARM:
  shmobile: INTC External IRQ pin driver on sh73a0") which was included
  in v3.10.

* This fixes a regression in the r8a7740 SoC due to
  9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq domain.")
  which was included in v3.18-rc2.


The following changes since commit 7a2071c58f36450fbf44a27d2e5d371c18534a25:

  ARM: shmobile: Add early debugging support using SCIF(A) (2014-11-17 10:29:58 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes-for-v3.19

for you to fetch changes up to b0ddb319db3d7a1943445f0de0a45c07a7f3457a:

  ARM: shmobile: sh73a0 legacy: Set .control_parent for all irqpin instances (2015-01-08 09:15:16 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v3.19

* Set .control_parent for all irqpin instances for sh73a0 SoC when booting
  using legacy C
* Instantiate GIC board for r8a7740 SoC when using legacy C

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7740: Instantiate GIC from C board code in legacy builds
      ARM: shmobile: sh73a0 legacy: Set .control_parent for all irqpin instances

 arch/arm/mach-shmobile/setup-r8a7740.c | 7 +++++++
 arch/arm/mach-shmobile/setup-sh73a0.c  | 3 +++
 2 files changed, 10 insertions(+)
