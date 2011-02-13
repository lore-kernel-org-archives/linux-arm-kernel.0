From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 13 Feb 2011 08:56:05 -0500 (EST)
Subject: [PATCH 2/2] P2V: Thumb2 support
In-Reply-To: <20110213114243.GC4799@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1102121331220.14920@xanadu.home>
	<20110213114243.GC4799@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1102130841240.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Feb 2011, Russell King - ARM Linux wrote:

> On Sat, Feb 12, 2011 at 01:33:42PM -0500, Nicolas Pitre wrote:
> >  __fixup_a_pv_table:
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
> > +	lsls	r0, r6, #24
> > +	lsr	r6, #8
> > +	beq	1f
> > +	clz	r7, r0
> > +	lsrs	r0, #24
> > +	lsls	r0, r7
> 
> Why do these instructions need to update the PSR?

Strictly speaking they don't.  It's just a size optimization.  There is 
a 16-bit encoding for them while their non-PSR-updating counterparts 
have only a 32-bit encoding.

> > +	strh	ip, [r7, #2]
> > +4:	cmp	r4, r5
> > +        ldrcc   r7, [r4], #4	@ use branch for delay slot
> > +        bcc	2b
> > +        bx	lr
> 
> Something's wrong with the indentation here.

Right, spaces instead of tabs, fixed.


Nicolas
