From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 13 Dec 2010 16:45:10 +0800
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <AANLkTincg=mOt+5sHSDU-Oiz_ETpoCg010fO52QNNZRM@mail.gmail.com>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
	<20101206080606.GA29563@n2100.arm.linux.org.uk>
	<AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
	<20101206101100.GB29563@n2100.arm.linux.org.uk>
	<AANLkTinuQWszBuA01zDkXBM5gWOsxYufWQFyqYQmOcbP@mail.gmail.com>
	<20101208134140.GB9777@n2100.arm.linux.org.uk>
	<AANLkTinWANEgSqioEUtR6UcwD7JK1hpXuspKQGqEctko@mail.gmail.com>
	<20101212144934.GI8665@n2100.arm.linux.org.uk>
	<AANLkTincg=mOt+5sHSDU-Oiz_ETpoCg010fO52QNNZRM@mail.gmail.com>
Message-ID: <AANLkTimnQgW2K+n4Ttgi=jzkh0xXSkgA5B5bj7ZYGwKc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 10:50 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sun, Dec 12, 2010 at 10:49 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Sun, Dec 12, 2010 at 10:33:01PM +0800, Eric Miao wrote:
>>> On Wed, Dec 8, 2010 at 9:41 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>> > On Tue, Dec 07, 2010 at 09:31:11PM +0800, Eric Miao wrote:
>>> >> +#ifdef CONFIG_MULTI_IRQ_HANDLER
>>> >> + ? ? ldr ? ? r1, =handle_arch_irq
>>> >> + ? ? ldr ? ? r0, [r1]
>>> >> + ? ? cmp ? ? r0, #0
>>> >> + ? ? movne ? r0, sp
>>> >> + ? ? adrne ? lr, BSYM(9997f)
>>> >> + ? ? ldrne ? pc, [r1]
>>> >> +#endif
>>> >
>>> > You might as well do this:
>>> > ...
>>
>>> +#ifdef CONFIG_MULTI_IRQ_HANDLER
>>> + ? ? ldr ? ? r1, =handle_arch_irq
>>> + ? ? ldr ? ? r0, [r1]
>>> + ? ? cmp ? ? r0, #0
>>> + ? ? movne ? r0, sp
>>> + ? ? adrne ? lr, BSYM(9997f)
>>> + ? ? ldrne ? pc, [r1]
>>> +#endif
>>
>> This looks suspiciously like the old version to me.
>>
>
> Yeah, my brain malfunctioned. :-)
>

Hi Russell,

I've submitted the patch to your patch tracking system with the line
below:

The assembly code to invoke handle_arch_irq is optimized by Russell
King.

Shame that it now looks I did almost nothing to this patch :-)
