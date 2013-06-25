From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 25 Jun 2013 10:24:47 +0200
Subject: [PATCH] ARM: at91/PMC: fix at91sam9n12 USB FS init
In-Reply-To: <51C9264C.6050400@atmel.com>
References: <1372071462-29063-1-git-send-email-nicolas.ferre@atmel.com>
 <51C9264C.6050400@atmel.com>
Message-ID: <51C953CF.4070805@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/06/2013 07:10, Bo Shen :
> Hi Nicolas,
>
> On 06/24/2013 06:57 PM, Nicolas Ferre wrote:
>> at91sam9n12 has Full-speed only USB. So we should add
>> it to the list in at91_pllb_usbfs_clock_init() function.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>   arch/arm/mach-at91/clock.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
>> index 978de42..2f732d9 100644
>> --- a/arch/arm/mach-at91/clock.c
>> +++ b/arch/arm/mach-at91/clock.c
>> @@ -699,7 +699,7 @@ static void __init
>> at91_pllb_usbfs_clock_init(unsigned long main_clock)
>>           at91_pmc_write(AT91_PMC_SCER, AT91RM9200_PMC_MCKUDP);
>>       } else if (cpu_is_at91sam9260() || cpu_is_at91sam9261() ||
>>              cpu_is_at91sam9263() || cpu_is_at91sam9g20() ||
>> -           cpu_is_at91sam9g10()) {
>> +           cpu_is_at91sam9g10() || cpu_is_at91sam9n12()) {
>>           uhpck.pmc_mask = AT91SAM926x_PMC_UHP;
>>           udpck.pmc_mask = AT91SAM926x_PMC_UDP;
>>       }
>>
>
> As you post the following patches:
>    ARM: at91/PMC: fix at91sam9n12 USB FS init
> (https://patchwork.kernel.org/patch/2772301/)
>
> This patch no need anymore.

Absolutely.

Bye,
-- 
Nicolas Ferre
