From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 10 Nov 2014 20:01:04 +0100
Subject: [GIT PULL] arm: pxa: pxa for v3.19
Message-ID: <87bnoevq1b.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-3.19

for you to fetch changes up to af1e3ad7be02013b7481b0997919d16b871bc907:

  arm: pxa: add pxa27x device-tree support (2014-11-10 00:31:26 +0100)

----------------------------------------------------------------
arm: pxa: pxa for v3.19

Hello Arnd, Kevin, Olof,

This is a very quiet release, featuring a small cleanup, a tosa change
on its charger driver, and support for pxa device-tree based pxa27x
boards.

The device-tree part will only be fully activated once clocks support
is fully operational in the common clock framework.

----------------------------------------------------------------
Dmitry Eremin-Solenikov (1):
      ARM: pxa: tosa: switch to gpio-charger

Joe Perches (1):
      arm: mach-pxa: Convert pr_warning to pr_warn

Robert Jarzmik (4):
      arm: pxa: add device-tree irq init for pxa27x
      arm: pxa: move init functions into generic.h
      arm: pxa: remove unnecessary includes from pxa-dt
      arm: pxa: add pxa27x device-tree support

 arch/arm/mach-pxa/Kconfig               | 11 ++++++
 arch/arm/mach-pxa/Makefile              |  1 +
 arch/arm/mach-pxa/em-x270.c             |  4 +-
 arch/arm/mach-pxa/generic.h             | 65 +++++++++++++++++++++------------
 arch/arm/mach-pxa/gumstix.c             |  3 +-
 arch/arm/mach-pxa/include/mach/pxa25x.h |  8 ----
 arch/arm/mach-pxa/include/mach/pxa27x.h |  4 --
 arch/arm/mach-pxa/include/mach/pxa3xx.h |  5 ---
 arch/arm/mach-pxa/mfp-pxa2xx.c          | 12 +++---
 arch/arm/mach-pxa/poodle.c              |  2 +-
 arch/arm/mach-pxa/pxa-dt.c              | 18 +++++++--
 arch/arm/mach-pxa/pxa27x.c              |  6 +++
 arch/arm/mach-pxa/pxa3xx-ulpi.c         |  6 +--
 arch/arm/mach-pxa/raumfeld.c            | 26 ++++++-------
 arch/arm/mach-pxa/tosa.c                | 41 ++++-----------------
 15 files changed, 107 insertions(+), 105 deletions(-)

-- 
Robert
