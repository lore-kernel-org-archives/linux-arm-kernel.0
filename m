From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 8 Feb 2016 16:42:18 +0530
Subject: [PATCH 0/3] omap: hwmod: add default reset handling support
Message-ID: <1454929941-23949-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new hwmod flag to indicate custom reset handling and use it
for devices that require custom reset handling (like dsp, ipu, iva).

Tested PCIe on dra7-evm and dra72-evm.
I need help in testing DSP, IPU, IVA, PRU, GFX, M3 in other platforms.
Or a way to test these cores to see if reset is not broken. Suman?

I'll post this series once again after performing these tests.

Paul Walmsley (3):
  ARM: omap2+: omap_hwmod: introduce hwmod flag for custom reset
    handling
  ARM: OMAP2+: hwmod: use HWMOD_CUSTOM_HARDRESET for custom reset
    handling
  ARM: OMAP2+: hwmod: Add default reset handling

 arch/arm/mach-omap2/omap_hwmod.c                   |   16 +++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.h                   |   12 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    2 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2 ++
 10 files changed, 41 insertions(+), 5 deletions(-)

-- 
1.7.9.5
