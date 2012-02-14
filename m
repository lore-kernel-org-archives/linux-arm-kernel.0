From: michal.wrobel@flytronic.pl (=?UTF-8?B?TWljaGHFgiBXcsOzYmVs?=)
Date: Tue, 14 Feb 2012 13:21:47 +0100
Subject: [PATCH RESEND] ixp4xx: clockevent set_next_event fix
In-Reply-To: <20120214120153.GA9808@localhost.localdomain>
References: <4F394D3B.3080909@flytronic.pl> <4F3A2F79.6050806@flytronic.pl>
 <20120214120153.GA9808@localhost.localdomain>
Message-ID: <4F3A51DB.70000@flytronic.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2012 13:01, Richard Cochran wrote:
> On Tue, Feb 14, 2012 at 10:55:05AM +0100, Micha? Wr?bel wrote:
>> IXP43x Developer's Manual [17.4.3] and IXP4[56]x Developer's Manual
>> [18.4.3] say that (...)
>>
>> IXP42x Developer's Manual [14.3] says that (...)
> Unless you test this out and confirm that it works for all IXP4xx, I
> would prefer to see a specific timer function for the 43x instead.
>
> Thanks,
> Richard
I think I might have some IXP425-based boards available for testing.
However, I certainly don't have any IXP45x- or IXP46x-based board. Maybe
I'll prepare a small kernel module that will allow to easily test this
issue by other list members who have IXP45x- and IXP46x-based boards?

Regards,
Micha?
>> Signed-off-by: Micha? Wr?bel <michal.wrobel@flytronic.pl>
>> ---
>>  arch/arm/mach-ixp4xx/common.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> The previous patch had a mistake in the description - wrong reference to
>> "General-Purpose Timers" section in IXP42x Developer's Manual.
>>
>> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
>> index 3841ab4..fd37c83 100644
>> --- a/arch/arm/mach-ixp4xx/common.c
>> +++ b/arch/arm/mach-ixp4xx/common.c
>> @@ -434,6 +434,7 @@ static int ixp4xx_set_next_event(unsigned long evt,
>>  {
>>  	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
>>  
>> +	*IXP4XX_OSRT1 = 0;
>>  	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | opts;
>>  
>>  	return 0;
>> -- 
>> 1.7.5.4
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
