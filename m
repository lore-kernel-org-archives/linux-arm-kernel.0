From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 May 2012 11:29:13 -0600
Subject: [PATCH 0/3] ARM: OMAP: AM35xx: fix some boot warnings with AM3505/3517
Message-ID: <20120510172449.13418.66815.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series fixes some of the warnings observed at boot with the AM35xx
boards.  Intended for either the 3.5 or 3.5-rc merge windows.

Particularly appreciated would be some feedback on the "ARM: OMAP:
AM35xx: fix UART4 softreset" patch from people who know the AM35xx SoC
hardware.


- Paul

---

am35xx_hwmod_data_fixes_a_3.5
   text	   data	    bss	    dec	    hex	filename
6601274	 724684	5587616	12913574	 c50ba6	vmlinux.omap2plus_defconfig.orig
6601274	 724748	5587616	12913638	 c50be6	vmlinux.omap2plus_defconfig

Paul Walmsley (3):
      ARM: OMAP AM35xx: clock and hwmod data: fix AM35xx HSOTGUSB hwmod
      ARM: OMAP AM35xx: clock and hwmod data: fix UART4 data
      ARM: OMAP: AM35xx: fix UART4 softreset


 arch/arm/mach-omap2/clock3xxx_data.c       |   26 +++++++++++--------
 arch/arm/mach-omap2/cm-regbits-34xx.h      |    4 +--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   38 ++++++++++++++++++++--------
 arch/arm/mach-omap2/prcm-common.h          |    4 +--
 4 files changed, 46 insertions(+), 26 deletions(-)
