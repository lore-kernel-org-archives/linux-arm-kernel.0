From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 18 Sep 2017 18:20:29 +0200
Subject: [GIT PULL] ARM: at91: fixes for 4.14 #1
Message-ID: <20170918162029.15894-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Arnd, Olof,

Here are some fixes for 4.14. I send them while Alexandre is in the US. The
most of this PR are modifications to the sama5d27 SOM1 EK board that was
introducts lately. These modifications are errors due to typos, misunderstanding
of the DT binding or simply last minute hardware modifications.
I also added one patch for the AT91 PM subsystem as it is the re-alignment on
one treewide change by Russell to get rid of virt_to_phys() in low-level code.
I think that unifying this move the soonest for all ARM platform is better.

Thanks, best regards,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to 093d79f62a89f47d9b5fd0746768146d9696535c:

  ARM: at91: Replace uses of virt_to_phys with __pa_symbol (2017-09-18 10:05:38 +0200)

----------------------------------------------------------------
Fixes for 4.14:
- three DT fixes for the newly introduced sama5d27_som1_ek board
- one treewide modification that didn't touch this new PM code: we
  synchronize now to be coherent with the other ARM platforms

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: Replace uses of virt_to_phys with __pa_symbol

Ludovic Desroches (2):
      ARM: dts: at91: sama5d27_som1_ek: update pinmux/pinconf for LEDs and USB
      ARM: dts: at91: sama5d27_som1_ek: fix typos

Nicolas Ferre (1):
      ARM: dts: at91: sama5d27_som1_ek: fix USB host vbus

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 19 +++++++++++--------
 arch/arm/mach-at91/pm.c                     |  4 ++--
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
Nicolas Ferre
