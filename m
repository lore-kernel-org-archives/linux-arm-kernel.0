From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Dec 2013 09:50:58 -0800
Subject: [GIT PULL] omap display regression fix against v3.13-rc4
Message-ID: <20131218175057.GF27438@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/display-fix

for you to fetch changes up to 130f769e81fc472beb2211320777e26050e3fa15:

  Revert "ARM: OMAP2+: Remove legacy mux code for display.c" (2013-12-17 16:28:34 -0800)

----------------------------------------------------------------
I accidentally removed some mux code for omap4 that I thought was
dead code as omap4 has been booting with device tree only since
v3.10. Turns out I also removed some display related mux code,
so let's revert that except for the dead code parts.

----------------------------------------------------------------
Tomi Valkeinen (1):
      Revert "ARM: OMAP2+: Remove legacy mux code for display.c"

 arch/arm/mach-omap2/display.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
