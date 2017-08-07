From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 7 Aug 2017 12:53:27 +0300
Subject: [PATCH] pinctrl: sirf: atlas7: fix of_irq_get() error check
In-Reply-To: <CACRpkdbftXpS2W+=nBZnfmskjM30f5W0xxChBsCteAm5hy1fsw@mail.gmail.com>
References: <20170730193855.099325987@cogentembedded.com>
 <CACRpkdbW2efOy+qH+JPHYnbaUHkf2eqcWGm66C9a1K+uj_QNdA@mail.gmail.com>
 <5ce7636a-e839-7aab-ce33-7c1e57437d8a@cogentembedded.com>
 <CACRpkdbftXpS2W+=nBZnfmskjM30f5W0xxChBsCteAm5hy1fsw@mail.gmail.com>
Message-ID: <1810e3d5-792b-f108-0f1a-1d9bd24c0876@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 8/7/2017 12:07 PM, Linus Walleij wrote:

>>>> of_irq_get() may return  any negative error number as well as 0 on
>>>> failure,
>>>> while the driver only checks for -EPROBE_DEFER, blithely continuing with
>>>> the call to gpiochip_set_chained_irqchip() -- that function expects the
>>>> parent IRQ as *unsigned int*, so would probably do nothing  when a large
>>>> IRQ number resulting from a conversion of a negative error number is
>>>> passed
>>>> to it, however passing 0 would probably work but the driver won't receive
>>>> valid GPIO bank interrupts.
>>>>
>>>> Check for 'ret <= 0' instead and return -ENXIO from the driver's probe
>>>> iff
>>>> of_irq_get() returned 0.
>>>>
>>>> Fixes: f9367793293d ("pinctrl: sirf: add sirf atlas7 pinctrl and gpio
>>>> support")
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>>
>>> Patch applied!
>>
>>
>>    Thanks! But to which branch? I'm not seeing it in linux-pinctrl.git...
> 
> devel.

    Still not seeing the patch, perhaps you forgot to push?

> It seems the SiRF people are not using upstream (see other mails) so I do
> not see we need to expediate it to fixes.

    Up to you.

> Yours,
> Linus Walleij

MBR, Sergei
