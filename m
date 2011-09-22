From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 09:33:37 -0700
Subject: [GIT PULL] OMAP: omap_device cleanup for v3.2
In-Reply-To: <20110921182051.GH2937@atomide.com> (Tony Lindgren's message of
	"Wed, 21 Sep 2011 11:20:51 -0700")
References: <87mxe5tlzv.fsf@ti.com> <87y5xps6kv.fsf@ti.com>
	<20110921182051.GH2937@atomide.com>
Message-ID: <878vpgv8ny.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110915 16:23]:
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > Please pull this omap_device cleanup series for v3.2.  This sets the
>> > groundwork for Benoit's DT infrastructure work.
>> 
>> Turns out this series has a dependency on a patch[1] in Russell's
>> for-next branch.
>> 
>> Russell, any chance of picking this patch into your devel-stable so we
>> have a fixed point to merge with?
>
> Or maybe Kevin can add it to his series instead?

OK, Russell and I agreed (offline) that I would just take this patch,
and he will drop from his for-next branch.

I've cherry-picked it into the my branch, and here's the updated pull
request.  Should have no external dependencies now, and I compile tested
for OMAP1 and OMAP2+ on top of the arm-soc/next/cleanup branch.

Kevin


The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://gitorious.org/khilman/linux-omap-pm.git for_3.2/omap_device

Grazvydas Ignotas (1):
      OMAP: omap_device: make latency autoadjust messages debug

Jarkko Nikula (1):
      omap: mcbsp: Remove omap device API

Kevin Hilman (7):
      OMAP: omap_device: replace debug/warning/error prints with dev_* macros
      OMAP: omap_device: remove internal functions from omap_device.h
      OMAP: omap_device: when building return platform_device instead of omap_device
      OMAP: omap_device: device register functions now take platform_device pointer
      OMAP: omap_device: _disable_idle_on_suspend() takes platform_device pointer
      OMAP: omap_device: decouple platform_device from omap_device
      ARM: 7082/1: platform_device: pdev_archdata: add omap_device pointer

 arch/arm/include/asm/device.h                 |    5 +
 arch/arm/mach-omap2/devices.c                 |   44 +++---
 arch/arm/mach-omap2/display.c                 |    6 +-
 arch/arm/mach-omap2/dma.c                     |   16 +-
 arch/arm/mach-omap2/gpio.c                    |   10 +-
 arch/arm/mach-omap2/hsmmc.c                   |    8 +-
 arch/arm/mach-omap2/hwspinlock.c              |    8 +-
 arch/arm/mach-omap2/mcbsp.c                   |    8 +-
 arch/arm/mach-omap2/opp.c                     |    2 +-
 arch/arm/mach-omap2/pm.c                      |    8 +-
 arch/arm/mach-omap2/serial.c                  |   14 +-
 arch/arm/mach-omap2/sr_device.c               |    6 +-
 arch/arm/plat-omap/i2c.c                      |    8 +-
 arch/arm/plat-omap/include/plat/omap_device.h |   30 ++--
 arch/arm/plat-omap/mcbsp.c                    |   27 ----
 arch/arm/plat-omap/omap_device.c              |  185 +++++++++++++------------
 16 files changed, 185 insertions(+), 200 deletions(-)
