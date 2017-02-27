From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 27 Feb 2017 10:45:22 -0600
Subject: [PATCH 0/6] ARM: dts: socfpga: Fix dtc warnings
In-Reply-To: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <f70f5daa-2d24-041c-6e3a-195b7e1bde0b@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/24/2017 11:54 PM, Florian Vaussard wrote:
> We get a bunch of warnings when compiling the SoCFPGA device trees with W=1.
> This warnings happens because some nodes have a unit name but no 'reg' property,
> or are missing a unit name while having a 'reg' property. This series enables to
> compile all SoCFPGA dts without warnings.
> 
> Patches 1 to 5 fix these warnings by adding the unit name or removing the
> 'reg' property when approriate.
> 
> Patch 6 removes the inclusion of the deprecated skeleton.dtsi file, as SoCFPGA
> device trees already define the mandatory properties and nodes. This is needed
> to remove the latest warning.
> 
> This series was boot tested on a Cyclone5 SoC DK, thus covering some of the
> changes dones by patches 1 -> 3 + 6.
> 
> Regards,
> Florian
> 
> Florian Vaussard (6):
>   ARM: dts: socfpga: Add unit name to clock nodes
>   ARM: dts: socfpga: Add unit name to memory nodes
>   ARM: dts: socfpga: Remove unneeded unit names
>   ARM: dts: socfpga: Remove unneeded reg from stmpe_touchscreen
>   ARM: dts: socfpga: Remove unit name for LEDs in EBV SOCrates
>   ARM: dts: socfpga: Do not include skeleton.dtsi
> 
>  arch/arm/boot/dts/socfpga.dtsi                     | 43 +++++++++---------
>  arch/arm/boot/dts/socfpga_arria10.dtsi             | 51 +++++++++++-----------
>  arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |  2 +-
>  arch/arm/boot/dts/socfpga_arria5_socdk.dts         |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi        |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      |  1 -
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |  8 ++--
>  arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       |  2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |  2 +-
>  arch/arm/boot/dts/socfpga_vt.dts                   |  2 +-
>  13 files changed, 59 insertions(+), 62 deletions(-)
> 

All applied!

Thanks,
Dinh
