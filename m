From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  9 Aug 2017 16:56:23 +0800
Subject: [PATCH 0/4] Allwinner A64 SRAM C (DE2 SRAM) support
Message-ID: <20170809085627.32687-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DE2 in Allwinner A64 SoC requires the SRAM C to be claimed to work.

This patchset adds the support of SRAM C in A64 for the sunxi-sram driver.

As the SRAM C controlling bit is a little different with other peripherals'
SRAM controlling bit (inverted), a function value to register value
remapping is added, which is also useful for the SRAM C1 (VE SRAM) on some
SoCs.

Patch 1 is the device tree binding patch.

Patch 2 is a fix for the usage of the DE2 SRAM -- as it's claimed by a
clock driver, and kernel are trying to probe the DE2 clock driver before
probing sunxi-sram driver; this patch fixed probe defering when claiming
SRAM region.

Patch 3 adds the remapping code.

Patch 4 adds necessary codes for A64 SRAM C.

Icenowy Zheng (4):
  dt-bindings: add binding for Allwinner A64 SRAM controller and SRAM C
  drivers: soc: sunxi: fix error processing on base address when
    claiming
  drivers: soc: sunxi: add support for remapping func value to reg value
  drivers: soc: sunxi: add support for A64 and its SRAM C

 .../devicetree/bindings/sram/sunxi-sram.txt        |  9 +++-
 drivers/soc/sunxi/sunxi_sram.c                     | 57 ++++++++++++++++++----
 2 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.13.0
