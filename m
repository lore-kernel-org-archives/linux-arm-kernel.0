From: saaguirre@ti.com (Aguirre, Sergio)
Date: Wed, 13 Jan 2010 13:09:31 -0600
Subject: [PATCH] Offer 'uncacheable memory' as DMA coherent memory for
	ARMv6
In-Reply-To: <20100113190226.GF28292@n2100.arm.linux.org.uk>
References: <20100113180327.GE28292@n2100.arm.linux.org.uk>
	<A24693684029E5489D1D202277BE8944514AD02C@dlee02.ent.ti.com>
	<20100113190226.GF28292@n2100.arm.linux.org.uk>
Message-ID: <A24693684029E5489D1D202277BE8944514AD0DA@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, January 13, 2010 1:02 PM
> To: Aguirre, Sergio
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] Offer 'uncacheable memory' as DMA coherent memory for
> ARMv6
> 
> On Wed, Jan 13, 2010 at 12:22:11PM -0600, Aguirre, Sergio wrote:
> > (Replacing linux-arm-kernel at lists.arm.linux.org.uk with linux-arm-
> kernel at lists.infradead.org, as I got a SMTP error: "550 Please direct your
> message to the new mailing lists on lists.infradead.org")
> 
> Oops.
> 
> > > +config ARM_DMA_MEM_BUFFERABLE
> > > +	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
> > > +	default y
> >
> > Perhaps you meant here:
> >
> > default y if CPU_V6 && !CPU_V7
> 
> No - default y if CPU_V6 || CPU_V7 - we need it enabled for V7 CPUs.

Ok, my point was more about relocating the "if CPU_V6 && ..." condition just after "default y", rather than after Boolean declaration.

Anyways, I think you got it due to your response :).

Regards,
Sergio
