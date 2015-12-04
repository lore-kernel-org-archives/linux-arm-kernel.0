From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:32 +0100
Subject: [PATCH 00/10] ARM: debug-ll fixes
Message-ID: <1449268242-808553-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I've carried most of these patches for a very long time in
my randconfig tree, and they follow up on work that Daniel
Thompson did last year. Most of the changes are really trivial,
and I'd like to put them into my next/randconfig branch in
arm-soc for merging in 4.5.

The last patch for orion/mvebu is the only one that is slightly
tricky, but it would be good to have that as part of the
multiplatform conversion for orion5x/mv78xx0.

The patches are currently based on top of my randconfig branch,
and there will be conflicts trying to apply them on mainline,
but I can handle that inside of arm-soc.

	Arnd

Arnd Bergmann (10):
  ARM: debug-ll: fix UART configuration with ARCH_KEYSTONE
  ARM: debug-ll: reorganize mvebu debug uart config
  ARM: debug-ll: rework ep93xx handling
  ARM: debug-ll: rework SPEAr handling
  ARM: debug-ll: rework integrator/versatile handling
  ARM: debug-ll: rework gemini handling
  ARM: debug-ll: rework lpc32xx handling
  ARM: debug-ll: rework footbridge handling
  ARM: debug-ll: reorder Kconfig alphanumerically
  ARM: orion/mvebu: unify debug-ll virtual addresses

 arch/arm/Kconfig.debug                             | 397 ++++++++++++---------
 .../mach/debug-macro.S => include/debug/dc21285.S} |   0
 arch/arm/mach-dove/include/mach/dove.h             |  10 +-
 arch/arm/mach-mv78xx0/mv78xx0.h                    |   4 +-
 arch/arm/mach-orion5x/orion5x.h                    |   4 +-
 5 files changed, 238 insertions(+), 177 deletions(-)
 rename arch/arm/{mach-footbridge/include/mach/debug-macro.S => include/debug/dc21285.S} (100%)

-- 
2.1.0.rc2
