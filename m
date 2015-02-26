From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:41 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.1
Message-ID: <cover.1424931398.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.1.

Some of these changes are arguably cleanups and could have
been queued up in the soc-cleanups-for-v4.1 branch. However,
I am reluctant to reshuffle things between branches at this point.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.1

for you to fetch changes up to 72016d009e6bcf6cb6a289382bfc21185122b22e:

  ARM: shmobile: r8a7740: Remove restart callback (2015-02-24 08:02:49 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.1

* Remove restart callback from r8a7740 SoC
* Add support SOC_BUS to R-Car Gen2
* Expose SoCs revision data for R-Car Gen2
* Remove check for CONFIG_COMMON_CLK from R-Car Gen2 code as it is always set
* Allow R-Car Gen2 platforms to boot with CMA enabled and HIGHMEM disabled

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
      ARM: shmobile: r8a7740: Remove restart callback

Magnus Damm (1):
      ARM: shmobile: No R-Car Gen2 CMA reservation when HIGHMEM=n

Nobuhiro Iwamatsu (2):
      ARM: shmobile: Add function to get SoCs revision data for R-Car Gen2
      ARM: shmobile: Add support SOC_BUS to R-Car Gen2

 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/rcar-gen2.h       |  1 +
 arch/arm/mach-shmobile/setup-r8a7740.c   |  8 -----
 arch/arm/mach-shmobile/setup-r8a7790.c   |  1 +
 arch/arm/mach-shmobile/setup-r8a7791.c   |  1 +
 arch/arm/mach-shmobile/setup-r8a7794.c   |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 58 +++++++++++++++++++++++++++++---
 7 files changed, 58 insertions(+), 13 deletions(-)
