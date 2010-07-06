From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue,  6 Jul 2010 20:26:44 +0530
Subject: [PATCH 0/3] omap4: Add basic suspend support 
Message-ID: <1278428204-8419-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based of linux-omap "for-next" branch,also applies
to the latest 2.6.35-rc4 and is targeted for 2.6.36 merge window

It adds basic supsend and cpu hotplug support so that CONFIG_PM can be
enabled on all OMAP4 platforms. This is essential to keep build working
after Tony's "omap Kconfig improvments for 2.6.36 merge window" series
	
	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg31303.html

The following changes since commit e3dc03cb09a37ce61534c5922d3d383465f5e2ed:
  Tony Lindgren (1):
        omap: Add back UART MDR1 check into uncompress.h

are available in the git repository at:

  origin/for-next 

Rajendra Nayak (1):
  omap4: suspend: Add basic system suspend support

Santosh Shilimkar (2):
  omap4: Add smc API to read AuxCoreBoot0 register
  omap4: hotplug: Add basic CPU hotplug support

 arch/arm/mach-omap2/Makefile                    |    2 +
 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 +
 arch/arm/mach-omap2/omap-headsmp.S              |   16 ---
 arch/arm/mach-omap2/omap-hotplug.c              |   79 +++++++++++++
 arch/arm/mach-omap2/omap-smp.c                  |    3 +-
 arch/arm/mach-omap2/omap44xx-smc.S              |   25 ++++
 arch/arm/mach-omap2/pm44xx.c                    |  135 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/smp.h           |    1 +
 8 files changed, 251 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-hotplug.c
 create mode 100644 arch/arm/mach-omap2/pm44xx.c
