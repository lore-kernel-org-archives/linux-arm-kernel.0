From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:51 +0900
Subject: [GIT PULL v2 0/7] Second Round of Renesas ARM Based SoC Updates for
 v3.15
Message-ID: <cover.1393400446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this second round of Renesas ARM based SoC updates for v3.15.
As requested I have broken out clock changes into a separate branch which
I will send a pull-request for separately.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.15

for you to fetch changes up to c4ca5d80e03559fd95c526ece5ce39fc732a2511:

  ARM: shmobile: Move SYSC base variable to inside ifdefs (2014-02-26 14:53:35 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v3.15

* R-Car Gen2 SoCs: r8a7791 (R-Car M2) and r8a7790 (R-Car H2)
  - Remove __init from rcar_gen2_read_mode_pins()

* r8a7791 (R-Car M2)
  - Use 64-bit dma_addr_t

* r8a7790 (R-Car H2)
  - Add CA15-SCU, CA7-SCU
  - Add SYSC setup code
  - Use 64-bit dma_addr_t

----------------------------------------------------------------
Gaku Inami (1):
      ARM: shmobile: r8a7790 CA7-SCU enablement

Hisashi Nakamura (1):
      ARM: shmobile: r8a7790 SYSC setup code

Keita Kobayashi (1):
      ARM: shmobile: r8a7790 CA15-SCU enablement

Magnus Damm (4):
      ARM: shmobile: Use 64-bit dma_addr_t on r8a7790/r8a7791
      ARM: shmobile: Break out R-Car SYSC PM code
      ARM: shmobile: Remove __init from rcar_gen2_read_mode_pins()
      ARM: shmobile: Move SYSC base variable to inside ifdefs

 arch/arm/mach-shmobile/Kconfig                |   3 +
 arch/arm/mach-shmobile/Makefile               |   3 +-
 arch/arm/mach-shmobile/include/mach/pm-rcar.h |  15 +++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  13 +--
 arch/arm/mach-shmobile/include/mach/r8a7790.h |   1 +
 arch/arm/mach-shmobile/pm-r8a7779.c           | 131 ++----------------------
 arch/arm/mach-shmobile/pm-r8a7790.c           |  45 ++++++++
 arch/arm/mach-shmobile/pm-rcar.c              | 141 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c      |   2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c          |  17 ++--
 arch/arm/mach-shmobile/smp-r8a7790.c          |  17 ++++
 11 files changed, 244 insertions(+), 144 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/pm-rcar.h
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7790.c
 create mode 100644 arch/arm/mach-shmobile/pm-rcar.c
