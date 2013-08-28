From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 28 Aug 2013 11:59:13 +0530
Subject: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
In-Reply-To: <521CA8DF.9040400@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
 <521CA8DF.9040400@ti.com>
Message-ID: <521D98B9.4070902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013 06:55 PM, Santosh Shilimkar wrote:
> + Paul,
> 
> On Tuesday 27 August 2013 06:11 AM, Rajendra Nayak wrote:
>> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
>> use drivers/misc/sram.c driver instead of the omap internal
>> implementation for SRAM handling.
>>
>> Rajendra Nayak (2):
>>   ARM: AM335x: Get rid of unused sram init function
>>   ARM: OMAP4+: Move SRAM data to DT
>>
>>  arch/arm/boot/dts/am33xx.dtsi        |    5 +++++
>>  arch/arm/boot/dts/am4372.dtsi        |    5 +++++
>>  arch/arm/boot/dts/omap4.dtsi         |    5 +++++
>>  arch/arm/boot/dts/omap5.dtsi         |    5 +++++
>>  arch/arm/configs/omap2plus_defconfig |    1 +
>>  arch/arm/mach-omap2/sram.c           |   39 +---------------------------------
>>  arch/arm/mach-omap2/sram.h           |    1 -
>>  7 files changed, 22 insertions(+), 39 deletions(-)
>>
> Really nice to see the SRAM code getting moved now. Thanks
> a lot Rajendra.
> 
> - The sram_init() seems to be the post core init call.
> Hope this is not a problem for SDRC init which needs to have
> SRAM ready to update the DDR parameters.

It should be fine given its needed only during core dvfs. Besides
drivers/misc/sram.c is useful only on DT platforms, so for now OMAP2/3
continue to use the omap specific sram handling.

> 
> Regards,
> Santosh
> 
> 
