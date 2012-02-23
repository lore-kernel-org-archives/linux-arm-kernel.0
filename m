From: hector.oron@gmail.com (Hector Oron)
Date: Thu, 23 Feb 2012 17:49:34 +0100
Subject: [PATCH] efikamx: match machine descriptions with legacy
In-Reply-To: <CAHLCerPwJpM7x6WJ=1FUwJ96X-rgfLUEN840eoJ3SQsHg5gBDA@mail.gmail.com>
References: <1329779368-27878-1-git-send-email-hector.oron@gmail.com>
 <CAHLCerPwJpM7x6WJ=1FUwJ96X-rgfLUEN840eoJ3SQsHg5gBDA@mail.gmail.com>
Message-ID: <CAODfWeG4OpH1VkWOuHntUCygC8YVMfgTK=1onDweAZ8WYW6w+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2012/2/23 Amit Kucheria <amit.kucheria@linaro.org>:
> On Tue, Feb 21, 2012 at 1:09 AM, Hector Oron <hector.oron@gmail.com> wrote:

>> ?Rename machine descriptions to match legacy descriptions distributed by
>> ?manufacturer BSP. This way distributions can do clean upgrades from
>> ?userspace scripts which check for these values to differentiate platforms
>> ?with single kernel binaries.
>>
>> Signed-off-by: Hector Oron <hector.oron@gmail.com>
>> Acked-by: Matt Sealey <matt@genesi-usa.com>

> This is likely to break flash-kernel used in debian/ubuntu/linaro I
> suspect. Can you fix that too?

Surely, I can and I will do.

> Otherwise,
> Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

Thanks

>> ---
>> ?arch/arm/mach-mx5/board-mx51_efikamx.c | ? ?3 +--
>> ?arch/arm/mach-mx5/board-mx51_efikasb.c | ? ?2 +-
>> ?2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
>> index 3a5ed2d..fbfccc7 100644
>> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
>> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
>> @@ -283,8 +283,7 @@ static struct sys_timer mx51_efikamx_timer = {
>> ? ? ? ?.init = mx51_efikamx_timer_init,
>> ?};
>>
>> -MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
>> - ? ? ? /* Maintainer: Amit Kucheria <amit.kucheria@linaro.org> */
>> +MACHINE_START(MX51_EFIKAMX, "Genesi Efika MX (Smarttop)")
>> ? ? ? ?.atag_offset = 0x100,
>> ? ? ? ?.map_io = mx51_map_io,
>> ? ? ? ?.init_early = imx51_init_early,
>> diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
>> index 4baf05c..dedbca5 100644
>> --- a/arch/arm/mach-mx5/board-mx51_efikasb.c
>> +++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
>> @@ -483,7 +483,7 @@ static struct sys_timer mx51_efikasb_timer = {
>> ? ? ? ?.init ? = mx51_efikasb_timer_init,
>> ?};
>>
>> -MACHINE_START(MX51_EFIKASB, "Genesi Efika Smartbook")
>> +MACHINE_START(MX51_EFIKASB, "Genesi Efika MX (Smartbook)")
>> ? ? ? ?.atag_offset = 0x100,
>> ? ? ? ?.map_io = mx51_map_io,
>> ? ? ? ?.init_early = imx51_init_early,
>> --
>> 1.7.9
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.
