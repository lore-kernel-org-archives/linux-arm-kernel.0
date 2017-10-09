From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 9 Oct 2017 11:23:10 +0530
Subject: [PATCH 0/2] dra7/omap5: Increase max-voltage of pbias to 3.3v
Message-ID: <20171009055312.24165-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Max voltage of pbias was set to 3.0v because of an error in TRM in
omap5/dra7 SoCs. It's now corrected to be 3.3v.

Corresponding change in pbias regulator driver is already merged in
ulf -next
commit 27eae9d4b9d4cd9c204ef81f46078d91362ed41c
Author: Ravikumar Kattekola <rk@ti.com>
Date:   Thu Aug 31 15:48:45 2017 +0530

    regulator: pbias: Select voltage table based on max-voltage
    
    Reference manuals of OMAP5x and DRA7x have been updated to reflect
    the PBIAS regulator max-voltage as 3.3V instead of 3.0V, while OMAP3x
    and OMAP4x are still quoting 3.0V. So, as of now, the pbias driver
    needs to support both 3.0V and 3.3V IO voltage based on the max-voltage
    supported by the PBIAS regulator.
    
    Document reference:
    SWPU249AF - OMAP543x Technical reference manual - August 2016
    SPRUI30C ? DRA75x, DRA74x Technical reference manual November 2016
    
    Tested on:
    DRA75x PG 2.0 REV H EVM
    
    Signed-off-by: Ravikumar Kattekola <rk@ti.com>
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

Ravikumar Kattekola (2):
  ARM: dts: dra7: Increase max-voltage of pbias regulator
  ARM: dts: omap5: Increase max-voltage of pbias regulator

 arch/arm/boot/dts/dra7.dtsi  | 2 +-
 arch/arm/boot/dts/omap5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0
