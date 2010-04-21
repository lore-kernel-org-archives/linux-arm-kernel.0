From: steveb@workware.net.au (Steve Bennett)
Date: Wed, 21 Apr 2010 22:29:08 +1000
Subject: [PATCH] USB: gadget: pxa2xx: allow -1 for invalid gpio
In-Reply-To: <n2mf17812d71004202351w6a2edf79h53ff830733710687@mail.gmail.com>
References: <89D837B3-BCDC-48A4-BBF9-B292AE55D7AB@workware.net.au>
	<n2mf17812d71004202351w6a2edf79h53ff830733710687@mail.gmail.com>
Message-ID: <ED5EF328-13FB-4F60-8B47-9032253E16FB@workware.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2010, at 4:51 PM, Eric Miao wrote:

> On Wed, Apr 21, 2010 at 2:30 PM, Steve Bennett <steveb@workware.net.au> wrote:
>> gpio must be int, not u16, otherwise -1 isn't recognised
>> by gpio_is_valid().
>> 
>> Signed-off-by: Steve Bennett <steveb@workware.net.au>
> 
> Ack.
> 
> And better submit a patch as well for pxa2xx_udc.c to allow -1 as no GPIO.

Both pxa25x_udc.c and pxa_27x_udc.c already use gpio_is_valid() which checks >= 0.

Unless I'm missing something, there is nothing else to do there.

> 
>> ---
>>  arch/arm/include/asm/mach/udc_pxa2xx.h |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
>> index f3eabf1..833306e 100644
>> --- a/arch/arm/include/asm/mach/udc_pxa2xx.h
>> +++ b/arch/arm/include/asm/mach/udc_pxa2xx.h
>> @@ -21,8 +21,8 @@ struct pxa2xx_udc_mach_info {
>>         * here.  Note that sometimes the signals go through inverters...
>>         */
>>        bool    gpio_vbus_inverted;
>> -       u16     gpio_vbus;                      /* high == vbus present */
>> +       int     gpio_vbus;                      /* high == vbus present */
>>        bool    gpio_pullup_inverted;
>> -       u16     gpio_pullup;                    /* high == pullup activated */
>> +       int     gpio_pullup;                    /* high == pullup activated */
>>  };
>> 
>> 
>> 
>> --
>> ?Web: Embedded Web Framework - http://uweb.workware.net.au/
>> WorkWare Systems Pty Ltd
>> W: www.workware.net.au      P: 0434 921 300
>> E: steveb at workware.net.au   F: 07 3102 9221
