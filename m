From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Sep 2014 13:22:17 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Soc Updates for v3.18
Message-ID: <cover.1410235571.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC soc updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-soc2-for-v3.18,
which you have already pulled.

This pull-request has a minor conflict with
"[GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.18",
tagged as renesas-kconfig-cleanups-for-v3.18, which you
have previously pulled.


The solution is to take both and the conflicting area of
arch/arm/mach-shmobile/Kconfig should look like this:

config ARCH_R8A7791
        bool "R-Car M2-W (R8A77910)"
        select ARCH_RCAR_GEN2

config ARCH_R8A7794
        bool "R-Car E2 (R8A77940)"
        select ARCH_RCAR_GEN2

comment "Renesas ARM SoCs Board Type"

This resolution can be found in the renesas-next-20140905-v3.17-rc2 tag
of my renesas tree on kernel.org.


The following changes since commit 86155b35d173317518458c6f9c0a3ea8c5324bed:

  ARM: shmobile: Move legacy INTC definitions from irqs.h to intc.h (2014-08-22 12:23:32 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.18

for you to fetch changes up to 5923abb205e05773e0bb16c7ca4c0b41dbeec40e:

  ARM: shmobile: Initial r8a7794 SoC support (2014-09-05 17:23:49 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Soc Updates for v3.18

* Initial r8a7794 SoC support
* Support Cortex-A7 in shmobile_init_delay()

----------------------------------------------------------------
Ulrich Hecht (2):
      ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
      ARM: shmobile: Initial r8a7794 SoC support

 arch/arm/mach-shmobile/Kconfig         |  4 ++++
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/setup-r8a7794.c | 35 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/timer.c         |  9 +++++----
 4 files changed, 45 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
