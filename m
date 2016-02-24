From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:21:25 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC Updates for v4.6
Message-ID: <cover.1456275652.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.6.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.6

for you to fetch changes up to 71d076ceb245f0d9a05e552bbebd5911660bd2ac:

  ARM: shmobile: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains (2016-02-19 14:52:41 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.6

* Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains
* Move emev2_smp_ops to emev2
* Remove legacy map_io callbacks on r8a7740 and emev2 SoCs
* Migrate to generic l2c OF initialization on r8a7740

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
      ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers
      ARM: shmobile: r8a7740: Remove legacy machine_desc.map_io() callback
      ARM: shmobile: emev2: Remove legacy machine_desc.map_io() callback
      ARM: shmobile: emev2: Move declaration of emev2_smp_ops to emev2.h
      ARM: shmobile: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains

 arch/arm/mach-shmobile/Kconfig         | 13 +++++++-----
 arch/arm/mach-shmobile/emev2.h         |  6 ++++++
 arch/arm/mach-shmobile/setup-emev2.c   | 22 ++-----------------
 arch/arm/mach-shmobile/setup-r8a7740.c | 39 ++--------------------------------
 arch/arm/mach-shmobile/smp-emev2.c     |  2 ++
 5 files changed, 20 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/emev2.h
