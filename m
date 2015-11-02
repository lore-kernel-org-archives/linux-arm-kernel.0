From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Nov 2015 18:26:15 +0000
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com>
 <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
Message-ID: <20151102182615.GI2684@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +ENTRY(tango_smc)
> > +	push	{lr}
> > +	mov	ip, r1
> > +	dsb
> 
> Did you ever get a straight answer on the dsb here?

We didn't. Having a look just now, the earliest example appears to be
in OMAP4 L2 support patches back in 2009 [1]. I was not able to find a
rationale.

Given that the MMU is on (and speculative accesses are permitted) I
can't see what the DSB achieves -- it can't quiesce the memory system.

Santosh, any idea?

Thanks,
Mark.

> > +	smc	#0
> > +	pop	{pc}
> > +ENDPROC(tango_smc)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005815.html
