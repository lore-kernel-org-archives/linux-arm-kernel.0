From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:07 +0530
Subject: [PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state'
Message-ID: <cover.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

This series migrates ARM clockevent drivers (present in arch/arm/
directory), to the new set-state interface. This would enable these
drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
device (if required), as the set-mode interface is marked obsolete now
and wouldn't be expanded to handle new states.

Rebased over: v4.2-rc1

Following patches:
  ARM/ks8695/time: Migrate to new 'set-state' interface
  ARM/omap1/time: Migrate to new 'set-state' interface

must be integrated to mainline kernel via clockevents tree, because of
dependency on:
  352370adb058 ("clockevents: Allow set-state callbacks to be optional")


Other patches don't have this dependency and so can be pushed via
platform specific trees if Maintainers want it that way.

This has been build/boot tested by two bots on various platforms for few
days now:

- kernelci, http://kernelci.org/
- 0-DAY kernel test infrastructure, kbuild test robot


Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Roland Stigge <stigge@antcom.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>

Viresh Kumar (18):
  ARM/smp_twd: Migrate to new 'set-state' interface
  ARM/cns3xxx/timer: Migrate to new 'set-state' interface
  ARM/davinci/time: Migrate to new 'set-state' interface
  ARM/dc21285-timer: Migrate to new 'set-state' interface
  ARM/gemini/time: Migrate to new 'set-state' interface
  ARM/imx/epit: Migrate to new 'set-state' interface
  ARM/ixp4xx/timer: Migrate to new 'set-state' interface
  ARM/ks8695/time: Migrate to new 'set-state' interface
  ARM/lpc32xx/timer: Migrate to new 'set-state' interface
  ARM/mmp/time: Migrate to new 'set-state' interface
  ARM/netx/time: Migrate to new 'set-state' interface
  ARM/omap1/time: Migrate to new 'set-state' interface
  ARM/omap1/timer32: Migrate to new 'set-state' interface
  ARM/omap2/timer: Migrate to new 'set-state' interface
  ARM/SPEAr/time: Migrate to new 'set-state' interface
  ARM/w90x900/time: Migrate to new 'set-state' interface
  ARM/iop/time: Migrate to new 'set-state' interface
  ARM/orion/time: Migrate to new 'set-state' interface

 arch/arm/kernel/smp_twd.c                | 48 +++++++++--------
 arch/arm/mach-cns3xxx/core.c             | 55 ++++++++++---------
 arch/arm/mach-davinci/time.c             | 54 ++++++++++---------
 arch/arm/mach-footbridge/dc21285-timer.c | 48 ++++++++---------
 arch/arm/mach-gemini/time.c              | 69 ++++++++++++------------
 arch/arm/mach-imx/epit.c                 | 67 ++++++++++++-----------
 arch/arm/mach-ixp4xx/common.c            | 68 +++++++++++++----------
 arch/arm/mach-ks8695/time.c              | 43 ++++++++-------
 arch/arm/mach-lpc32xx/timer.c            | 40 +++++---------
 arch/arm/mach-mmp/time.c                 | 29 ++++------
 arch/arm/mach-netx/time.c                | 61 +++++++++++----------
 arch/arm/mach-omap1/time.c               | 35 ++++++------
 arch/arm/mach-omap1/timer32k.c           | 33 ++++++------
 arch/arm/mach-omap2/timer.c              | 48 ++++++++---------
 arch/arm/mach-spear/time.c               | 89 ++++++++++++++++--------------
 arch/arm/mach-w90x900/time.c             | 51 ++++++++++--------
 arch/arm/plat-iop/time.c                 | 70 ++++++++++++++----------
 arch/arm/plat-orion/time.c               | 93 ++++++++++++++++----------------
 18 files changed, 522 insertions(+), 479 deletions(-)

-- 
2.4.0
