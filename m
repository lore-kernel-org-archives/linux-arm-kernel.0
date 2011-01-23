From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 23 Jan 2011 19:57:23 +0530
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing
	inmdesc->map_io()
In-Reply-To: <alpine.LFD.2.00.1101230911350.8580@xanadu.home>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
	<20110122231528.GD11960@n2100.arm.linux.org.uk>
	<AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
	<alpine.LFD.2.00.1101230024240.8580@xanadu.home>
	<9dbba3c432aab294761c32527bc5e96d@mail.gmail.com>
	<alpine.LFD.2.00.1101230911350.8580@xanadu.home>
Message-ID: <50bdd960766a4b6e2398feebba350354@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico at fluxnic.net]
> Sent: Sunday, January 23, 2011 7:48 PM
> To: Santosh Shilimkar
> Cc: Eric Miao; Russell King - ARM Linux; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH 1/2] ARM: calculate VMALLOC_END by probing
> inmdesc->map_io()
>
[...]

> > > Can we possibly get away with a global VMALLOC_END?  What if we
> were
> > > to
> > > decide it is fixed at 0xf0000000 for everyone?
> > >
> > Which would potentialy shrink the lowmem and vmalloc area. With
> > current flexibility of adjustable VMALLOC_END, in 1G:3G model,
> > we managed to  have almost ~ 896 MB virtual space available
> > for lowmem + vmalloc. So keeping 128MB for vmalloc ~768MB of
> > memory can be directly addressable without highmem support.
>
> OK, I just wanted to see if people do think that the simplicity of a
> global definition would have made the per-architecture flexibility
> irrelevant.  But looking at some of the mappings it seems that quite
> a
> lot of virtual space wastage would be imposed in some cases.
>
Yep.

> Plus, moving vmalloc_end to the machine record is almost as simple
> while
> preserving the current flexibility.
>
As long we can maintain current flexibility, there shouldn't be
any problem.

Regards,
Santosh
