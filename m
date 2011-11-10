From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 10 Nov 2011 02:00:55 +0200
Subject: [PATCH] ARM: OMAP: Fix map_io for Amstrad E3
In-Reply-To: <20111109233900.GP15294@n2100.arm.linux.org.uk>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
 <20111109231900.GS31337@atomide.com> <20111109232525.GT31337@atomide.com>
 <20111109233900.GP15294@n2100.arm.linux.org.uk>
Message-ID: <20D8B951-2E77-42DF-B735-6062994D47D5@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10.11.2011, at 1.39, Russell King - ARM Linux wrote:
> On Wed, Nov 09, 2011 at 03:25:25PM -0800, Tony Lindgren wrote:
>> Commit 7b88e62f5d219a86d81bdf4388012c97dc42e8f8 (ARM: OMAP1: Use  
>> generic
>> map_io, init_early and init_irq) changed omap1 to use generic map_io.
>>
>> Looks like I missed one board though. Fix this by adding a custom
>> map_io for Amstrad E3.
>>
>> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> ---
>> Untested, does this help?
>> --- a/arch/arm/mach-omap1/board-ams-delta.c
>> +++ b/arch/arm/mach-omap1/board-ams-delta.c
>> @@ -302,8 +302,6 @@ static void __init ams_delta_init(void)
>>  	omap_cfg_reg(J19_1610_CAM_D6);
>>  	omap_cfg_reg(J18_1610_CAM_D7);
>>
>> -	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
>> -
>
> This is definitely wrong.  Using iotable_init() after map_io has  
> returned
> has (and remains) a serious bug - doing so may _appear_ to work but  
> as it
> doesn't obtain its memory from the standard kernel memory  
> allocators, it
> will lead to duplicate usage of that memory.

Also, the patch did not help. It still hangs like before.

A.
