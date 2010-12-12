From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Dec 2010 14:49:34 +0000
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <AANLkTinWANEgSqioEUtR6UcwD7JK1hpXuspKQGqEctko@mail.gmail.com>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
	<20101206080606.GA29563@n2100.arm.linux.org.uk>
	<AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
	<20101206101100.GB29563@n2100.arm.linux.org.uk>
	<AANLkTinuQWszBuA01zDkXBM5gWOsxYufWQFyqYQmOcbP@mail.gmail.com>
	<20101208134140.GB9777@n2100.arm.linux.org.uk>
	<AANLkTinWANEgSqioEUtR6UcwD7JK1hpXuspKQGqEctko@mail.gmail.com>
Message-ID: <20101212144934.GI8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 10:33:01PM +0800, Eric Miao wrote:
> On Wed, Dec 8, 2010 at 9:41 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Dec 07, 2010 at 09:31:11PM +0800, Eric Miao wrote:
> >> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> >> + ? ? ldr ? ? r1, =handle_arch_irq
> >> + ? ? ldr ? ? r0, [r1]
> >> + ? ? cmp ? ? r0, #0
> >> + ? ? movne ? r0, sp
> >> + ? ? adrne ? lr, BSYM(9997f)
> >> + ? ? ldrne ? pc, [r1]
> >> +#endif
> >
> > You might as well do this:
> > ...

> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	ldr	r1, =handle_arch_irq
> +	ldr	r0, [r1]
> +	cmp	r0, #0
> +	movne	r0, sp
> +	adrne	lr, BSYM(9997f)
> +	ldrne	pc, [r1]
> +#endif

This looks suspiciously like the old version to me.
