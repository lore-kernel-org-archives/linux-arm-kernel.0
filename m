From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Mar 2015 16:00:48 +0100
Subject: [GIT PULL] at91: fixes for 4.0 #3
Message-ID: <1426086048-25681-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Some fixes for 4.0. Most of them are for USB and some issues that we hit with
the clocks. The cleanup of the cpu_is_at91xxxx() macros for multi-platform led
to rework some USB compatibility strings to handle particularities of some SoCs.
A compilation error in case of thumb2 kernel build is also solved.

Thanks, best regards,

The following changes since commit 5957457a2d96e4c9b2fecd40f29cdb3bb841d75e:

  ARM: at91/pm: MOR register KEY was missing (2015-03-05 11:43:02 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes3

for you to fetch changes up to e7b848d731cdf681e06138a2ae4380220a6baac8:

  ARM: at91: pm_slowclock: fix the compilation error (2015-03-11 15:49:47 +0100)

----------------------------------------------------------------
Third fixes batch for AT91 on 4.0:
- clock fixes for USB
- compatible string changes for handling USB IP differences
  (+ needed AHB matrix syscon)
- fix of a compilation error in PM code

----------------------------------------------------------------
Boris Brezillon (3):
      ARM: at91/dt: at91sam9261: fix clocks and clock-names in udc definition
      ARM: at91/dt: declare matrix node as a syscon device
      ARM: at91/dt: fix at91 udc compatible strings

Nicolas Ferre (1):
      ARM: at91/dt: fix USB high-speed clock to select UTMI

Wenyou Yang (1):
      ARM: at91: pm_slowclock: fix the compilation error

 arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi | 9 +++++----
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 arch/arm/mach-at91/pm_slowclock.S  | 2 ++
 8 files changed, 14 insertions(+), 11 deletions(-)

-- 
Nicolas Ferre
