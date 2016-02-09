From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 9 Feb 2016 10:43:22 +0530
Subject: [PATCH 0/3] omap: hwmod: add default reset handling support
In-Reply-To: <20160208204446.GC19432@atomide.com>
References: <1454929941-23949-1-git-send-email-kishon@ti.com>
 <20160208204446.GC19432@atomide.com>
Message-ID: <56B97572.6080100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tuesday 09 February 2016 02:14 AM, Tony Lindgren wrote:
> Hi Kishon,
> 
> * Kishon Vijay Abraham I <kishon@ti.com> [160208 03:13]:
>> Add a new hwmod flag to indicate custom reset handling and use it
>> for devices that require custom reset handling (like dsp, ipu, iva).
>>
>> Tested PCIe on dra7-evm and dra72-evm.
>> I need help in testing DSP, IPU, IVA, PRU, GFX, M3 in other platforms.
>> Or a way to test these cores to see if reset is not broken. Suman?
>>
>> I'll post this series once again after performing these tests.
> 
> Do we also still need to patch something in the pcie driver too
> or can all that be left out now?

With this series changes in PCIe driver is not required at all.

Thanks
Kishon

> 
> Regards,
> 
> Tony
> 
> 
>> Paul Walmsley (3):
>>   ARM: omap2+: omap_hwmod: introduce hwmod flag for custom reset
>>     handling
>>   ARM: OMAP2+: hwmod: use HWMOD_CUSTOM_HARDRESET for custom reset
>>     handling
>>   ARM: OMAP2+: hwmod: Add default reset handling
>>
>>  arch/arm/mach-omap2/omap_hwmod.c                   |   16 +++++++++++-----
>>  arch/arm/mach-omap2/omap_hwmod.h                   |   12 ++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 ++
>>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
>>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    2 ++
>>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    1 +
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +++
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    1 +
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++++++
>>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2 ++
>>  10 files changed, 41 insertions(+), 5 deletions(-)
>>
>> -- 
>> 1.7.9.5
>>
