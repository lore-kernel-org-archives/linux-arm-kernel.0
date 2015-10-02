From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 Oct 2015 17:32:10 +0300
Subject: [PATCH] ARM: debug: add support for alternate 8250 register layout
In-Reply-To: <yw1x1tddmjng.fsf@unicorn.mansr.com>
References: <1443787929-19173-1-git-send-email-mans@mansr.com>
 <560E9268.60900@cogentembedded.com> <yw1x1tddmjng.fsf@unicorn.mansr.com>
Message-ID: <560E956A.6070700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/2/2015 5:26 PM, M?ns Rullg?rd wrote:

>>> Some SoCs have a UART with a non-standard register layout. This
>>> allows the debug console to work with these.
>>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>> ---
>>> I would have preferred a more accurate description of the UART, but I've
>>> not managed to figure out who the vendor is.
>>
>>     You haven't seem the Alchemy datasheets? I can send you some if so.
>
> I have.  They don't say where Alchemy bought the UART block.

    In fact, seeing at least Au1550 databook googling for "alchemy databook".
The UART registers are described there. Perhaps, it's not accurate enought for 
your needs, though...

>>> ---
>>>    arch/arm/Kconfig.debug        |  4 ++++
>>>    arch/arm/include/debug/8250.S | 12 ++++++++++++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>>> index 0cfd7f9..8d5c837 100644
>>> --- a/arch/arm/Kconfig.debug
>>> +++ b/arch/arm/Kconfig.debug
>>> @@ -1597,6 +1597,10 @@ config DEBUG_UART_8250_WORD
>>>    		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
>>>    		DEBUG_BRCMSTB_UART
>>>
>>> +config DEBUG_UART_8250_AU
>>> +       bool "8250 UART has Alchemy register layout"
>>> +       depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
>>> +
>>
>>     So Alchemy UART got reused on ARM?
>
> The UART is actually a Palmchip IP core used by several SoC companies.

    Hm, how have you figured out that;s Palmchip if the Alchemy databooks are 
silent about that? :-)

MBR, Sergei
