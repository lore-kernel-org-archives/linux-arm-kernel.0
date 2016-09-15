From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 15 Sep 2016 14:11:03 +0530
Subject: [GIT PULL 2/3] DaVinci dts updates for v4.9
In-Reply-To: <3347114.RAnckMhlMa@wuerfel>
References: <20160824110006.1866-1-nsekhar@ti.com>
 <20160824110006.1866-2-nsekhar@ti.com> <3347114.RAnckMhlMa@wuerfel>
Message-ID: <211a1af8-d76b-62af-08ac-a374d3285c0a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday 14 September 2016 09:23 PM, Arnd Bergmann wrote:
> On Wednesday, August 24, 2016 4:30:05 PM CEST Sekhar Nori wrote:
>> DaVinci DA850 device-tree enhancements include:
>>
>> - Support for new board OMAP-L138 LCDK
>> - Add AEMIF node on DA850 EVM and use it for NAND
>> - Audio support for LCDK
>> - Cleanups for PWM and UART
>>
>>
> 
> This one fails to build:
> 
> 
> ERROR (phandle_references): Reference to non-existent node or label "nand_cs3_pins"
> 
> ERROR: Input tree has errors, aborting (use -f to force output)
>   DTC     arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb
> 
> 
> Can you send a fixed version please?

Did the merge happen cleanly? There should be no nand_cs3_pins if the
merge was clean. It should be removed with 31e3a8817b66 ("ARM: dts:
da850,da850-evm: Add an aemif node and use it for the NAND").

If the merge was clean, can you please push the offending tree to some
place I can fetch and take a look. I dont have "nand_cs3_pins" in my
tree anymore nor I can reproduce the build break.

Thanks,
Sekhar
