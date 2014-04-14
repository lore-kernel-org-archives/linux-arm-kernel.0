From: nm@ti.com (Nishanth Menon)
Date: Mon, 14 Apr 2014 11:25:10 -0500
Subject: [PATCH 00/15] bus: omap_l3_noc: driver cleanups and support for
 DRA7/AM4372
Message-ID: <1397492726-17203-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The following series is based on v3.15-rc1 + peter's patch series:
	patch #1: https://patchwork.kernel.org/patch/3923141/
	(drivers: bus: omap_l3: Convert to use devm_kzalloc)

	patch #2: https://patchwork.kernel.org/patch/3923061/
	(drivers: bus: omap_l3: Convert to use devm_ioremap_resource() )

	patch #3: https://patchwork.kernel.org/patch/3923101/
	(drivers: bus: omap_l3: Convert to use devm_request_irq())

	patch #4: https://patchwork.kernel.org/patch/3923081/
	(drivers: bus: omap_l3: Remove the platform driver's remove function)

	patch #5: https://patchwork.kernel.org/patch/3923121/
	(drivers: bus: omap_l3: Change pr_crit() to dev_err() when IRQ request
	fails)

This series cleansup omap_l3_noc driver and adds data to support DRA7
and AM437x SoCs.

Patches(including Peter's) is available here:
https://github.com/nmenon/linux-2.6-playground/commits/l3noc/driver-fixes

DTS patches (once this series is integrated and related DRA7 memory map fixes are done):
https://github.com/nmenon/linux-2.6-playground/commits/l3noc/dts-fixes

Testing branch: everything integrated:
https://github.com/nmenon/linux-2.6-playground/commits/l3noc/testing

Test log:
	am43xx-epos:  Boot PASS: http://slexy.org/raw/s2GQJIppWp
	DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s20OfeDbO6
	pandaboard-es:  Boot PASS: http://slexy.org/raw/s2AZSmSYcN
	sdp4430:  Boot PASS: http://slexy.org/raw/s2IfHAbrJA
	OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21CkL8glk

Afzal Mohammed (1):
  bus: omap_l3_noc: Add AM4372 interconnect error data

Nishanth Menon (10):
  bus: omap_l3_noc: Fix copyright information
  bus: omap_l3_noc: switch over to relaxed variants of readl/writel
  bus: omap_l3_noc: un-obfuscate l3_targ address computation
  bus: omap_l3_noc: move L3 master data structure out
  bus: omap_l3_noc: convert target information into a structure
  bus: omap_l3_noc: make error reporting and handling common.
  bus: omap_l3_noc: populate l3->dev and use it
  bus: omap_l3_noc: remove iclk from omap_l3 struct
  bus: omap_l3_noc: convert flagmux information into a structure
  bus: omap_l3_noc: introduce concept of submodule

Rajendra Nayak (2):
  bus: omap_l3_noc: Add support for discountinous flag mux input
    numbers
  bus: omap_l3_noc: Add DRA7 interconnect error data

Sricharan R (2):
  bus: omap_l3_noc: rename functions and data to omap_l3
  bus: omap_l3_noc: use of_match_data to pick up SoC information

 .../devicetree/bindings/arm/omap/l3-noc.txt        |    2 +
 drivers/bus/omap_l3_noc.c                          |  224 +++++----
 drivers/bus/omap_l3_noc.h                          |  495 +++++++++++++++-----
 3 files changed, 517 insertions(+), 204 deletions(-)

-- 
1.7.9.5
