From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 5 Apr 2013 10:05:33 +0200
Subject: [PATCH 0/5] ARM: OMAP: DMTIMER updates for v3.10
In-Reply-To: <20130404183855.GP10155@atomide.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
 <20130404183855.GP10155@atomide.com>
Message-ID: <515E85CD.1060307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 08:38 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130319 10:42]:
>> Includes:
>> - A couple fixes for DMTIMER context loss handling.
>> - Populating DMTIMER errata when booting with device-tree.
>> - A new function for requesting a DMTIMER by device-tree node.
>>
>> Based upon v3.9-rc3.
>>
>> Tested on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 Blaze
>> and AM335x EVM. Testing includes ...
>> 1. Booting kernel on above boards
>> 2. Testing of various DMTIMER request APIs
>> 3. Testing the timer overflow and match interrupts.
>> 4. Using different clock sources to operate the timer with.
>>
>> Jon Hunter (4):
>>   ARM: OMAP: Force dmtimer restore if context loss is not detectable
>>   ARM: OMAP: Add function to request timer by node
>>   ARM: dts: OMAP2+: Update DMTIMER compatibility property
>>   ARM: OMAP2+: Populate DMTIMER errata when using device-tree
>>
>> NeilBrown (1):
>>   ARM: OMAP: Simplify dmtimer context-loss handling
>>
>>  .../devicetree/bindings/arm/omap/timer.txt         |   17 +-
>>  arch/arm/boot/dts/am33xx.dtsi                      |   14 +-
>>  arch/arm/boot/dts/omap2.dtsi                       |   22 +-
>>  arch/arm/boot/dts/omap2420.dtsi                    |    2 +-
>>  arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
>>  arch/arm/boot/dts/omap3.dtsi                       |   24 +-
>>  arch/arm/boot/dts/omap4.dtsi                       |   22 +-
>>  arch/arm/boot/dts/omap5.dtsi                       |   22 +-
>>  arch/arm/mach-omap2/timer.c                        |    7 +-
>>  arch/arm/plat-omap/dmtimer.c                       |  241 ++++++++++++--------
>>  arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
>>  11 files changed, 220 insertions(+), 154 deletions(-)
> 
> For all these it sounds like it's best that Benoit queues
> them with the .dts changes:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Great.

Jon,

I've just applied the whole series and will push it soon.

Thanks,
Benoit
