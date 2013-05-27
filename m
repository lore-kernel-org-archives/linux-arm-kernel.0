From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:44 +0900
Subject: [GIT PULL] Renesas ARM based sh73a0 SoC updates for v3.11
Message-ID: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-sh73a0-for-v3.11

for you to fetch changes up to 8a6fca8ecd467a6255bda134d89fcda9ae1556ce:

  ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate (2013-05-25 09:57:10 +0900)

----------------------------------------------------------------
Renesas ARM based sh73a0 SoC updates for v3.11

* Change by Magnus Damm to use shmobile_setup_delay() when initialising
  the SoC using C-code, as was already the case when initialising the
  SoC using OF. This allows boot with TWD only.
* CPUFreq support by Guennadi Liakhovetski
* Clean-ups from Magnus Damm and Simon Horman to use DEFINE_RES_MEM()
* Clean-up from Maxime Ripard to remove unnecessary init_irq declaration in
  machine description.

----------------------------------------------------------------
Guennadi Liakhovetski (4):
      ARM: shmobile: sh73a0: add support for adjusting CPU frequency
      ARM: shmobile: sh73a0: add CPUFreq support
      ARM: shmobile: sh73a0: do not overwrite all div4 clock operations
      ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate

Magnus Damm (2):
      ARM: shmobile: sh73a0 pinmux platform device cleanup
      ARM: shmobile: sh73a0: Always use shmobile_setup_delay()

Maxime Ripard (1):
      ARM: shmobile: sh73a0: Remove init_irq declaration in machine description

Simon Horman (1):
      ARM: shmobile: sh73a0: Use DEFINE_RES_MEM*() everywhere

 arch/arm/mach-shmobile/Kconfig        |    2 +
 arch/arm/mach-shmobile/clock-sh73a0.c |  111 +++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c |  122 ++++++++-------------------------
 3 files changed, 141 insertions(+), 94 deletions(-)
