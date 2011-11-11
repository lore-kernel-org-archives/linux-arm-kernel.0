From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Nov 2011 12:30:07 +0000
Subject: [GIT PULL] VIC DT+MULTI_IRQ_HANDLER patches
Message-ID: <20111111123007.GD5114@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I've updated the VIC series to include export.h and added some Tested-by 
and Acked-by's.

This is dependent on https://lkml.org/lkml/2011/11/10/186 (irq: fix 
possible null-pointer deref irq_domain_to_irq) which hasn't been picked 
up yet so I understand if you don't want to hold up your GIC patches, 
but I'll defer to you on that!

Thanks,

Jamie

The following changes since commit ad2cf1a746915c5c95edaba104dcb50023fb18d1:

  ARM: GIC: Make MULTI_IRQ_HANDLER mandatory (2011-11-08 10:10:10 +0000)

are available in the git repository at:
  git://github.com/jamieiles/linux-2.6-ji.git vic-dt

Jamie Iles (11):
      ARM: vic: device tree binding
      ARM: vic: MULTI_IRQ_HANDLER handler
      ARM: ep93xx: convert to MULTI_IRQ_HANDLER
      ARM: netx: convert to MULTI_IRQ_HANDLER
      ARM: nomadik: convert to MULTI_IRQ_HANDLER
      ARM: spear: convert to MULTI_IRQ_HANDLER
      ARM: u300: convert to MULTI_IRQ_HANDLER
      ARM: versatile: convert to MULTI_IRQ_HANDLER
      ARM: samsung: convert to MULTI_IRQ_HANDLER
      ARM: picoxcell: convert to MULTI_IRQ_HANDLER
      ARM: VIC: remove non MULTI_IRQ_HANDLER support

 Documentation/devicetree/bindings/arm/vic.txt      |   29 ++++
 arch/arm/common/Kconfig                            |    2 +
 arch/arm/common/vic.c                              |  143 ++++++++++++++++----
 arch/arm/include/asm/entry-macro-vic2.S            |   57 --------
 arch/arm/include/asm/hardware/vic.h                |   10 ++-
 arch/arm/mach-ep93xx/adssphere.c                   |    2 +
 arch/arm/mach-ep93xx/edb93xx.c                     |    9 ++
 arch/arm/mach-ep93xx/gesbc9312.c                   |    2 +
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   42 ------
 arch/arm/mach-ep93xx/micro9.c                      |    5 +
 arch/arm/mach-ep93xx/simone.c                      |    2 +
 arch/arm/mach-ep93xx/snappercl15.c                 |    2 +
 arch/arm/mach-ep93xx/ts72xx.c                      |    2 +
 arch/arm/mach-netx/include/mach/entry-macro.S      |   13 --
 arch/arm/mach-netx/nxdb500.c                       |    2 +
 arch/arm/mach-netx/nxdkn.c                         |    2 +
 arch/arm/mach-netx/nxeb500hmi.c                    |    2 +
 arch/arm/mach-nomadik/board-nhk8815.c              |    2 +
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |   30 ----
 arch/arm/mach-picoxcell/common.c                   |    9 +-
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   11 +-
 arch/arm/mach-s5p64x0/include/mach/entry-macro.S   |    7 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |   25 ----
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   37 -----
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +
 arch/arm/mach-s5pv210/mach-torbreck.c              |    2 +
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |   27 ----
 arch/arm/mach-spear3xx/spear300_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear310_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear320_evb.c              |    2 +
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |   36 -----
 arch/arm/mach-spear6xx/spear600_evb.c              |    2 +
 arch/arm/mach-u300/include/mach/entry-macro.S      |   24 ----
 arch/arm/mach-u300/u300.c                          |    2 +
 arch/arm/mach-versatile/include/mach/entry-macro.S |   30 ----
 arch/arm/mach-versatile/versatile_ab.c             |    2 +
 arch/arm/mach-versatile/versatile_dt.c             |    2 +
 arch/arm/mach-versatile/versatile_pb.c             |    2 +
 44 files changed, 231 insertions(+), 365 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vic.txt
 delete mode 100644 arch/arm/include/asm/entry-macro-vic2.S
