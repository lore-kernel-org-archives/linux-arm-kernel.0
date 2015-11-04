From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 04 Nov 2015 21:41:13 +0000
Subject: [RESEND][PATCH] ARM: debug: add support for Palmchip 16550-like
 UART
In-Reply-To: <3941204.6gDbSNijjW@wuerfel> (Arnd Bergmann's message of "Wed, 04
 Nov 2015 21:39:46 +0100")
References: <1445950678-16097-1-git-send-email-mans@mansr.com>
 <3941204.6gDbSNijjW@wuerfel>
Message-ID: <yw1xsi4l7892.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 27 October 2015 12:57:57 Mans Rullgard wrote:
>> --- a/arch/arm/include/debug/8250.S
>> +++ b/arch/arm/include/debug/8250.S
>> @@ -9,6 +9,18 @@
>>   */
>>  #include <linux/serial_reg.h>
>>  
>> +#ifdef CONFIG_DEBUG_UART_8250_PALMCHIP
>> +
>> +#undef UART_TX
>> +#undef UART_LSR
>> +#undef UART_MSR
>> +
>> +#define UART_TX 1
>> +#define UART_LSR 7
>> +#define UART_MSR 8
>> +
>> +#endif
>> 
>
> Maybe use a separate file instead of an #ifdef?
>
> Something like
>
> arch/arm/include/debug/8250-palmchip.S:
>
> #include <linux/serial_reg.h>
>  
> #undef UART_TX
> #undef UART_LSR
> #undef UART_MSR
>
> #define UART_TX 1
> #define UART_LSR 7
> #define UART_MSR 8
>
> #include "8250.S"

Good idea.  I'll make a new patch.

-- 
M?ns Rullg?rd
mans at mansr.com
