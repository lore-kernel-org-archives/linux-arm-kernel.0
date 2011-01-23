From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 23 Jan 2011 12:45:55 +0530
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing
	inmdesc->map_io()
In-Reply-To: <alpine.LFD.2.00.1101230024240.8580@xanadu.home>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com><20110122231528.GD11960@n2100.arm.linux.org.uk><AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
	<alpine.LFD.2.00.1101230024240.8580@xanadu.home>
Message-ID: <9dbba3c432aab294761c32527bc5e96d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Nicolas Pitre
> Sent: Sunday, January 23, 2011 11:01 AM
> To: Eric Miao
> Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: calculate VMALLOC_END by probing
> inmdesc->map_io()
>
> On Sun, 23 Jan 2011, Eric Miao wrote:
>
> > On Sun, Jan 23, 2011 at 7:15 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > I'd instead suggest adding vmalloc_end to the machine
> description
> > > record.
> > >
> >
> > And since all boards sharing a same machine_class is going to use
> > the same value, I'd rather we first introduce struct machine_class
> > like in the patch I posted months ago?
>
> Can we possibly get away with a global VMALLOC_END?  What if we were
> to
> decide it is fixed at 0xf0000000 for everyone?
>
Which would potentialy shrink the lowmem and vmalloc area. With
current flexibility of adjustable VMALLOC_END, in 1G:3G model,
we managed to  have almost ~ 896 MB virtual space available
for lowmem + vmalloc. So keeping 128MB for vmalloc ~768MB of
memory can be directly addressable without highmem support.

Regards,
Santosh
