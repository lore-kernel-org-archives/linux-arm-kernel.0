From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Feb 2011 23:23:43 +0530
Subject: OMAP4: IRQ line of CortexA9 performance monitor
In-Reply-To: <yw1x62sd1f26.fsf@unicorn.mansr.com>
References: <AANLkTin3q+rv+fcgCE6nwTN+=v_uQzT-Sn++gr6ekXcp@mail.gmail.com>
	<yw1x62sd1f26.fsf@unicorn.mansr.com>
Message-ID: <e96b735de3303ad461e00ccc0ef61b8f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of M?ns Rullg?rd
> Sent: Monday, February 21, 2011 10:49 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: OMAP4: IRQ line of CortexA9 performance monitor
>
> Ming Lei <tom.leiming@gmail.com> writes:
>
> > Hi,
> >
> > From chapter 17 of "Interrupt controller", OMAP4 TRM, I can't
> > find what is the interrupt line of CortexA9 performance monitor
> > in omap4. Seems without this information, we can't use perf on
> > omap4.
> >
> > Any suggestions or ideas about it?
>
> The PMU interrupt is routed through the CTI, which needs to be
> properly
> configured.  Unfortunately, the CTI is not documented in the public
> TRM,
> and nobody has seen fit to submit a patch suitable for upstream.
> Some dirty hacks have been posted, though.
>
Mans is right. Last time I looked at this, the OMAP4 PMU support
needed some hacky code and was not fitting to the generic PMU
framework.

I will take a second look at it and see if a patch can be generated
for upstream.

Regards,
Santosh
