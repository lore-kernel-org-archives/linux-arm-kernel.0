From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 May 2015 13:42:57 +0200
Subject: [GIT PULL] pxa fixes for v4.1
Message-ID: <87r3r0jzge.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa, repairing lubbock and mainstone.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/fixes-for-v4.1-rc2

for you to fetch changes up to fc9e38c0f4d38bfc68b405cf48365d65f7b6319e:

  ARM: pxa: lubbock: use new pxa_cplds driver (2015-04-30 22:52:51 +0200)

----------------------------------------------------------------
ARM: pxa: fixes for v4.1-rc2

These fixes reenable the lubbock(pxa25x) and mainstone(pxa27x)
platforms, which were broken since the gpio handling was
converted to a driver, and the interrupt ordering broke the
external interrupts of these systems.

----------------------------------------------------------------
Robert Jarzmik (3):
      ARM: pxa: pxa_cplds: add lubbock and mainstone IO
      ARM: pxa: mainstone: use new pxa_cplds driver
      ARM: pxa: lubbock: use new pxa_cplds driver

 arch/arm/mach-pxa/Kconfig                  |   9 ++
 arch/arm/mach-pxa/Makefile                 |   1 +
 arch/arm/mach-pxa/include/mach/lubbock.h   |   7 +-
 arch/arm/mach-pxa/include/mach/mainstone.h |   6 +-
 arch/arm/mach-pxa/lubbock.c                | 108 +++++-----------
 arch/arm/mach-pxa/mainstone.c              | 115 ++++-------------
 arch/arm/mach-pxa/pxa_cplds_irqs.c         | 200 +++++++++++++++++++++++++++++
 7 files changed, 274 insertions(+), 172 deletions(-)
 create mode 100644 arch/arm/mach-pxa/pxa_cplds_irqs.c

Cheers.

-- 
Robert
