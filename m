From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 11 Oct 2013 21:48:44 +0530
Subject: [PATCH v3 1/3] gpio: davinci: add OF support
In-Reply-To: <CACRpkdYNexWWXuQ052xuQ4NOdXm2gt-+ByREKeGo-VAnbH4D2w@mail.gmail.com>
References: <1380902596-4693-1-git-send-email-sujithkv@ti.com>
 <1380902596-4693-2-git-send-email-sujithkv@ti.com>
 <CACRpkdYxegBSYXR1-98smUNnDXpyRHo_vuYdnr3r7zhawENiUA@mail.gmail.com>
 <CA+V-a8vyPyL0j0nPOZyjxrecusFzXovFPsNBLKYXns5ASWR-wg@mail.gmail.com>
 <CACRpkdYNexWWXuQ052xuQ4NOdXm2gt-+ByREKeGo-VAnbH4D2w@mail.gmail.com>
Message-ID: <CA+V-a8vH7VXqz=2cz-uD=YfRBRYrJ10K1Aptw28vV8gP+PiT2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 10/11/13, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 11, 2013 at 4:59 PM, Prabhakar Lad
> <prabhakar.csengg@gmail.com> wrote:
>> On 10/11/13, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Fri, Oct 4, 2013 at 6:03 PM, Prabhakar Lad
>>> <prabhakar.csengg@gmail.com> wrote:
>
>>>> +- ti,davinci-gpio-irq-base: Base from where GPIO interrupt numbering
>>>> starts.
>>>
>>> What is this?
>>>
>>> If I have ever ACKed this I have been drunk. I take it back.
>>>
>> here is the ACK https://patchwork.kernel.org/patch/2721181/
>
> And as suspected that version of the patch did not contain
> this strange node property.
>
The property did exist in the patch 'intc_irq_num', I just renamed
it and gave a proper description to it.

> Don't keep my ACK on patches if you change basic stuff like
> that, they need to be re-acked, this runs the risk of abusing
> my trust amongst other subsystem maintainers who might
> go and merge this because "aha the GPIO maintainer
> thinks that this is OK".
>
Agreed, I carry forwarded the ACK since it had minor changes.

>>> This "base" is a Linux-specific thing and has no place in the
>>> device tree, and shall not be there. You have to find some way to
>>> avoid this, what do you think some other OS should do with
>>> this value...
>>>
>>> All IRQs in Linux are assumed to be dynamically assigned numbers
>>> nowadays, with a property like this you can never switch on
>>> SPARSE_IRQ for the DaVinci.
>>>
>> Can you point to any alternative solution if you have any ?
>
> First convert this GPIO driver to use an irqdomain to map
> HW IRQs to Linux IRQs, and grab a few IRQ descriptors
> dynamically off the irq descriptor heap.
> Example: commit
> a6c45b99a658521291cfb66ecf035cc58b38f206
> "pinctrl/coh901: use irqdomain, allocate irqdescs"
>
> Then on a longer term convert DaVinci to use dynamically
> allocated IRQs for all interrupt controllers, and move it over
> to SPARSE_IRQ so you know this works.
>
Thanks for the pointers.
-- 
Regards,
--Prabhakar Lad
