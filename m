From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Nov 2010 03:25:12 -0700
Subject: [PATCH 0/3] OMAP: wd_timer: update integration code to use new hwmod
	changes
Message-ID: <20101116102205.27991.37909.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the OMAP watchdog timer integration code to take advantage of
the new hwmod upgrades added by the "OMAP2+: hwmod core upgrades for
2.6.38: first set" series, posted previously.  So that series needs
to be applied before these patches.

Charu, it would be great if you could take a look at these.

Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.


- Paul

---

wdt_2.6.38
   text	   data	    bss	    dec	    hex	filename
5709076	 470560	5608992	11788628 b3e154	vmlinux.omap2plus_defconfig.orig
5708892	 470560	5608992	11788444 b3e09c	vmlinux.omap2plus_defconfig.patched

Paul Walmsley (3):
      OMAP2+: wd_timer: separate watchdog disable code from the rest of mach-omap2/devices.c
      OMAP2+: wd_timer: disable on boot via hwmod postsetup mechanism
      OMAP: wd_timer: remove old, dead probing code


 arch/arm/mach-omap2/Makefile               |    2 -
 arch/arm/mach-omap2/devices.c              |   64 +---------------------------
 arch/arm/mach-omap2/io.c                   |   18 ++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 ++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++-
 arch/arm/mach-omap2/wd_timer.c             |   54 ++++++++++++++++++++++++
 arch/arm/mach-omap2/wd_timer.h             |   17 +++++++
 arch/arm/plat-omap/devices.c               |   38 -----------------
 10 files changed, 108 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm/mach-omap2/wd_timer.c
 create mode 100644 arch/arm/mach-omap2/wd_timer.h
