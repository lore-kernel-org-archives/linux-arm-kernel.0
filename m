From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 14:25:41 +0100
Subject: [PATCH] fixed unresolved symbol "at91_pm_set_standby" when built
 without CONFIG_PM
In-Reply-To: <CAP+RiCBHRiQ+exZ1iqVawDOb3teQVZkb8C7WmtXPJVN_O_GaBA@mail.gmail.com>
References: <CAP+RiCDKcBwJunmNF89kh1zoT0xKYRWvaBPHnijRafLU2MHf_g@mail.gmail.com>	<529C6A23.1040900@atmel.com>
 <CAP+RiCBHRiQ+exZ1iqVawDOb3teQVZkb8C7WmtXPJVN_O_GaBA@mail.gmail.com>
Message-ID: <529C8A55.90202@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 14:12, Brent Taylor :
> Signed-off-by: Brent Taylor <motobud@gmail.com>

Thanks. it is now queued in at91-3.13-fixes.

Best regards,

> On Mon, Dec 2, 2013 at 5:08 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> On 24/11/2013 19:02, Brent Taylor :
>>>
>>> If CONFIG_PM is not defined, then arch/arm/mach-at91/pm.c is not
>>> compiled in.  This patch creates an inline function that does nothing
>>> if CONFIG_PM is not defined.
>>
>>
>> Your "Signed-off-by" line is missing. Can you please quickly send it to me
>> (by just replying to this email)?
>>
>> Otherwise, seems reasonable:
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>>> ---
>>>    arch/arm/mach-at91/pm.h | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
>>> index 3ed190c..c5101dc 100644
>>> --- a/arch/arm/mach-at91/pm.h
>>> +++ b/arch/arm/mach-at91/pm.h
>>> @@ -16,7 +16,11 @@
>>>    #include <mach/at91_ramc.h>
>>>    #include <mach/at91rm9200_sdramc.h>
>>>
>>> +#ifdef CONFIG_PM
>>>    extern void at91_pm_set_standby(void (*at91_standby)(void));
>>> +#else
>>> +static inline void at91_pm_set_standby(void (*at91_standby)(void)) { }
>>> +#endif
>>>
>>>    /*
>>>     * The AT91RM9200 goes into self-refresh mode with this command, and
>>> will
>>> --
>>> 1.8.3.2
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>>
>> --
>> Nicolas Ferre
>
>


-- 
Nicolas Ferre
