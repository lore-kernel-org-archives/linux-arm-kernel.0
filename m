From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 19 Nov 2014 23:59:55 +0100
Subject: [GIT PULL] arm: pxa: pxa for v3.19
In-Reply-To: <4686660.cI7P5U9Kgy@wuerfel> (Arnd Bergmann's message of "Wed, 19
 Nov 2014 23:42:23 +0100")
References: <87bnoevq1b.fsf@free.fr> <201411192333.32448.arnd@arndb.de>
 <878uj67r2a.fsf@free.fr> <4686660.cI7P5U9Kgy@wuerfel>
Message-ID: <874mtu7q50.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> We are running a bit short on time though, and I'd like to have it
> merged earlier. If nobody else is using your branch, I can just do
> the rebase myself, since there are only a few patches in it.
>
> 	Arnd

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-3.19

for you to fetch changes up to 03ec7fe70c5ce850a20aabe66c88e1a39111f9dd:

  arm: pxa: add pxa27x device-tree support (2014-11-19 23:53:14 +0100)

----------------------------------------------------------------
arm: pxa: pxa for v3.19

Hello Arnd, Kevin, Olof,

This is a very quiet release, featuring a small cleanup, a tosa change
on its charger driver, and support for pxa device-tree based pxa27x
boards.

The device-tree part will only be fully activated once clocks support
is fully operation in the common clock framework.

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
