From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 28 May 2010 19:35:31 +0900
Subject: [PATCH 1/2] ARM: S5PV210: Add OneNAND device to the GONI board
In-Reply-To: <20100528103059.GC4720@trinity.fluff.org>
References: <4BFF6594.5050502@samsung.com>
	<20100528103059.GC4720@trinity.fluff.org>
Message-ID: <AANLkTimslHNP-QVjoJ8R40OCUg5LMyQZhieiOvlTsuQq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 7:30 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, May 28, 2010 at 03:41:24PM +0900, Joonyoung Shim wrote:
>> This patch is to support OneNAND device to the GONI board.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> i'd say the second signoff here is at best un-necessary as Joonyoung
> is the sender of the patch and at worst incorrect.
>
> there's acked-by or other tags for people who've reviewed or tested the
> patch.

it's already discussed. now we got the internal tree and go to mainline.
do you mean I send the patch instead of each developers?

Thank you,
Kyungmin Park
>
>> ---
>> ?arch/arm/mach-s5pv210/Kconfig ? ? | ? ?1 +
>> ?arch/arm/mach-s5pv210/mach-goni.c | ? ?1 +
>> ?2 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
>> index 0761eac..d0432c6 100644
>> --- a/arch/arm/mach-s5pv210/Kconfig
>> +++ b/arch/arm/mach-s5pv210/Kconfig
>> @@ -58,6 +58,7 @@ config MACH_GONI
>> ? ? ? bool "GONI"
>> ? ? ? select CPU_S5PV210
>> ? ? ? select ARCH_SPARSEMEM_ENABLE
>> + ? ? select S5PC110_DEV_ONENAND
>> ? ? ? help
>> ? ? ? ? Machine support for Samsung GONI board
>> ? ? ? ? S5PC110(MCP) is one of package option of S5PV210
>> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
>> index 4863b13..bea812f 100644
>> --- a/arch/arm/mach-s5pv210/mach-goni.c
>> +++ b/arch/arm/mach-s5pv210/mach-goni.c
>> @@ -72,6 +72,7 @@ static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
>> ?};
>>
>> ?static struct platform_device *goni_devices[] __initdata = {
>> + ? ? &s5pc110_device_onenand,
>> ?};
>>
>> ?static void __init goni_map_io(void)
>> --
>> 1.7.0.4
>
> --
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
>
