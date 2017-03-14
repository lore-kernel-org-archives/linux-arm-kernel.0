From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Mar 2017 14:06:35 -0700
Subject: [PATCH 0/4] Clean up omap hwmod code for dynamic allocation
Message-ID: <20170314210639.2065-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In preparation for eventually configuring omap hwmod data from device tree
we need to make few changes in preparation for allocating data dynamically.

Regards,

Tony

Tony Lindgren (4):
  ARM: OMAP2+: Remove mostly unused hwmod linkspace
  ARM: OMAP2+: Use list_for_each_entry for hwmod slave_ports
  ARM: OMAP2+: Remove unnecessary hwmod clockact
  ARM: OMAP2+: Make hwmod clkdm_name const

 arch/arm/mach-omap2/omap_hwmod.c                   | 199 ++-------------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  16 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   1 -
 7 files changed, 15 insertions(+), 210 deletions(-)

-- 
2.11.1
