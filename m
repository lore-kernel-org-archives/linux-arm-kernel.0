From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 12:16:05 +0200
Subject: [PATCH 0/4] ARM: Remove boilerplate debug_ll_io_init code
Message-ID: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The recent introduction of debug_ll_io_init made possible to not rely
anymore on a custom map_io function but on debug_ll_io_init for the
early mapping and then on the various drivers to do the needed mappings for
the kernel to boot.

Some architectures begin to use only this function as the map_io callback in
the machine description.

In order to remove some boilerplate code, make the ARM mm code call
debug_ll_io_init by itself when no .map_io callback is defined.

This has been tested on the sunxi platform.

Thanks,
Maxime

Maxime Ripard (4):
  ARM: mmu: Call debug_ll_io_init if no map_io function is specified
  ARM: highbank: remove the .map_io declaration
  ARM: mxs: remove the .map_io declaration
  ARM: sunxi: Remove the .map_io function declaration

 arch/arm/mach-highbank/highbank.c |  1 -
 arch/arm/mach-mxs/mach-mxs.c      |  1 -
 arch/arm/mach-sunxi/sunxi.c       | 17 -----------------
 arch/arm/mach-sunxi/sunxi.h       | 20 --------------------
 arch/arm/mm/mmu.c                 |  2 ++
 5 files changed, 2 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-sunxi/sunxi.h

-- 
1.8.1.2
