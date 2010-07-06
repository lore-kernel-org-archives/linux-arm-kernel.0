From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 06 Jul 2010 16:09:22 +0900
Subject: [PATCH] ARM: S5P: Add PMU device
In-Reply-To: <00a201cb1cbd$594371a0$0bca54e0$%kim@samsung.com>
References: <1278294411-5104-1-git-send-email-jy0922.shim@samsung.com>
	<005f01cb1c3f$c464d150$4d2e73f0$%kim@samsung.com>
	<4C328D3A.7060701@samsung.com>
	<00a201cb1cbd$594371a0$0bca54e0$%kim@samsung.com>
Message-ID: <4C32D6A2.306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2010 12:43 PM, Kukjin Kim wrote:
> Joonyoung Shim wrote:
>> On 7/5/2010 9:44 PM, Kukjin Kim wrote:
>>> Joonyoung Shim wrote:
>>>> This patch adds an initcall for the s5p platforms so that they register
>>>> their PMU IRQs with the PMU framework in the Kernel.
>>>>
>>> Please include Ben Dooks email address in the CC.
>> OK.
>>
>>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>>> ---
>>>>  arch/arm/mach-s5p6442/include/mach/irqs.h |    2 +-
>>>>  arch/arm/mach-s5pc100/include/mach/irqs.h |    1 +
>>>>  arch/arm/mach-s5pv210/include/mach/irqs.h |    1 +
>>>>  arch/arm/plat-s5p/Makefile                |    1 +
>>>>  arch/arm/plat-s5p/dev-pmu.c               |   37
>>>> +++++++++++++++++++++++++++++
>>>>  5 files changed, 41 insertions(+), 1 deletions(-)
>>>>  create mode 100644 arch/arm/plat-s5p/dev-pmu.c
>>>>
>>>> diff --git a/arch/arm/mach-s5p6442/include/mach/irqs.h b/arch/arm/mach-
>>>> s5p6442/include/mach/irqs.h
>>>> index 02c2374..22173cc 100644
>>>> --- a/arch/arm/mach-s5p6442/include/mach/irqs.h
>>>> +++ b/arch/arm/mach-s5p6442/include/mach/irqs.h
>>>> @@ -32,7 +32,7 @@
>>>>  #define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
>>>>
>>>>  /* VIC1 */
>>>> -#define IRQ_nPMUIRQ 		S5P_IRQ_VIC1(0)
>>>> +#define IRQ_PMUIRQ		S5P_IRQ_VIC1(0)
>>> I'm not sure this changing is better..as you know, nXXX has some meaning.
>>>
>> Otherwise, we should redefine it and s5p6440 was defined to IRQ_PMUIRQ.
>>
> Hmm..so I said...I'm not sure... :-)
> OK...just IRQ_PMUIRQ looks good.
> 
>>>>  #define IRQ_ONENAND 		S5P_IRQ_VIC1(7)
>>>>  #define IRQ_UART0 		S5P_IRQ_VIC1(10)
>>>>  #define IRQ_UART1 		S5P_IRQ_VIC1(11)
>>>> diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-
>>>> s5pc100/include/mach/irqs.h
>>>> index 28aa551..9cc1b0d 100644
>>>> --- a/arch/arm/mach-s5pc100/include/mach/irqs.h
>>>> +++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
>>>> @@ -110,5 +110,6 @@
>>>>  #define IRQ_LCD_FIFO		IRQ_LCD0
>>>>  #define IRQ_LCD_VSYNC		IRQ_LCD1
>>>>  #define IRQ_LCD_SYSTEM		IRQ_LCD2
>>>> +#define IRQ_PMUIRQ		IRQ_CORTEX0
>>>>
>>> I think, we don't need remapping in here.
>>> How about use direct mapping like following:
>>> #define IRQ_PMUIRQ	S5P_IRQ_VIC1(0)
>>>
>> I don't care, but above codes uses already remapping.
>>
> Yeah, used remapping..but written by IRQ_LCD[0-2] in datasheet.
> In the PMUIRQ case, written by CORTEX0(nPMUIRQ).
> ...
> Anyway, I mean just no need IRQ_CORTEX0.
> 
> So suggested direct mapping like above.
> I think, we don't need to add an unused code.
> 

I don't know what means 'n' character of nPMUIRQ. If you are fine, let 
decide to use IRQ_PMUIRQ instead of IRQ_nPMUIRQ and IRQ_CORTEX0.
How about this?
