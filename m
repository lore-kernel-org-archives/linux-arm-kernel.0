From: vigneshr@ti.com (Vignesh R)
Date: Fri, 21 Nov 2014 15:44:20 +0530
Subject: [PATCH v3 0/2] Add support for ADC on am437x-gp and am43x-epos-evm
Message-ID: <1416564862-23056-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches enable ADC on am437x-gp-evm and am43x-epos-evm.
tscadc DT node has been added to am437x-gp and am43x-epos DT files.
With these patches, ADC functionalities are now available on am43xx.

Change log:

v3:
Add ADC hwmod data to AM43xx hwmod file instead
of sharing hwmod structures betweem AM33xx and
AM43xx.

v2:
Removed phy addresses in hwmod. Using DT instead.
Removed unused "ti,am4372" compatible string.
Use macro to set clk domain name.
Fixed subject format of all patches


Vignesh R (2):
  ARM: OMAP2+: hwmod: AM43x: add hwmod support for ADC on AM43xx
  ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and
    am43x-epos-evm

 arch/arm/boot/dts/am4372.dtsi              | 20 +++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts        |  8 ++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |  8 ++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 39 ++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

-- 
1.9.1
