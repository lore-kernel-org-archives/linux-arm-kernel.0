From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Mar 2013 20:04:10 -0500
Subject: [PATCHv1 0/2] ARM: socfpga: Soft reset, hotplug and device tree
 clocks
In-Reply-To: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
Message-ID: <5141220A.7050008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On 03/13/2013 04:55 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi Arnd/Olof,
> 
> Just 2 patches for mach-socfpga:
> 
> 0001: ARM: socfpga: Enable hotplug and soft reset
> 	- Able to hotplug CPU1 by putting it into reset and bringing back online.
> 

Have you seen the discussion on PSCI? There's an ARM doc on it and
Linaro session from last week. Is there a possibility you can use that?
You would need to be able to run in non-secure mode and implement smc calls.

Rob


> 0002: ARM: socfpga: Add clock entries into device tree
> 	- Correctly use the clock framework with device tree entries.
> 	- Based from clk-highbank.c
> 	
> Based on arm-soc/for-next.
> 	
> Thanks,
> Dinh
> 
> Dinh Nguyen (2):
>   ARM: socfpga: Enable hotplug and soft reset
>   ARM: socfpga: Add clock entries into device tree
> 
>  .../bindings/arm/altera/socfpga-clk-manager.txt    |   11 ++
>  .../devicetree/bindings/clock/altr_socfpga.txt     |   15 ++
>  arch/arm/boot/dts/socfpga.dtsi                     |  154 +++++++++++++++++
>  arch/arm/boot/dts/socfpga_cyclone5.dts             |    8 +
>  arch/arm/boot/dts/socfpga_vt.dts                   |    8 +
>  arch/arm/mach-socfpga/core.h                       |   17 ++
>  arch/arm/mach-socfpga/platsmp.c                    |    9 +-
>  arch/arm/mach-socfpga/socfpga.c                    |   16 +-
>  drivers/clk/socfpga/clk.c                          |  174 +++++++++++++++++---
>  9 files changed, 387 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/altr_socfpga.txt
> 
