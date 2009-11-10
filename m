From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 10 Nov 2009 15:35:26 +0800
Subject: enabling EXT_WAKEUP interrupts on PXA3xx
In-Reply-To: <f17812d70911092334l545dd53ev8e2980abca1293ed@mail.gmail.com>
References: <4AF91498.3060503@compulab.co.il>
	<20091110072818.GN14091@buzzloop.caiaq.de>
	<f17812d70911092334l545dd53ev8e2980abca1293ed@mail.gmail.com>
Message-ID: <f17812d70911092335v3e198921u878f406a8c59ffda@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2009 at 3:34 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Nov 10, 2009 at 3:28 PM, Daniel Mack <daniel@caiaq.de> wrote:
>> On Tue, Nov 10, 2009 at 09:22:00AM +0200, Mike Rapoport wrote:
>>> We need to enable EXT_WAKEUP interrupts on PXA3xx and I wonder what would be the
>>> best way to do it.
>>> I see two possibilities:
>>> 1) add 'if (irq == IRQ_WAKEUPx)' statements to pxa_{un}mask_irq functions in
>>> arch/arm/mach-pxa/irq.c
>>> 2) register additional irq_chip in arch/arm/mach-pxa/pxa3xx.c that will be
>>> responsible for handling EXT_WAKEUP (and probably other pxa3xx specific) interrupts.
>>>
>>> What do you prefer?
>>
>> I'm just calling
>>
>> ?enable_irq_wake(IRQ_WAKEUP0);
>>
>> from my board support code, and it works fine - no need to change
>> anything else.
>>
>
> Daniel,
>
> I think Mike is talking about "interrupt" on EXT_WAKEUP0, which involves
> register PECR.
>
> My POV is the 2nd way to go, should be better and cleaner, but I'm always
> wondering where to add these additional two interrupts, possibly before
> the GPIO IRQs or after.
>

Well, my second thought on this would be after GPIO IRQs and treat
them as board specific ones.
