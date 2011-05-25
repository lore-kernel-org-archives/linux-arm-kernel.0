From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 May 2011 11:02:26 +0800
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <4DDBC8C7.4000001@gmail.com>
References: <20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
	<4DDA2AC0.1060406@gaisler.com>
	<20110523095829.GG17672@n2100.arm.linux.org.uk>
	<BANLkTink1rrC8F3Gjhqt84gYzOibX+AgDQ@mail.gmail.com>
	<4DDBC8C7.4000001@gmail.com>
Message-ID: <20110525030225.GA30394@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 10:03:35AM -0500, Rob Herring wrote:
> Grant,
> 
> On 05/23/2011 10:09 AM, Grant Likely wrote:
> >On Mon, May 23, 2011 at 3:58 AM, Russell King - ARM Linux
> ><linux@arm.linux.org.uk>  wrote:
> >>On Mon, May 23, 2011 at 11:37:04AM +0200, Kristoffer Glembo wrote:
> >>>Grant Likely wrote:
> >>>>In the case we're talking about the bus really is an AMBA bus, and all
> >>>>the devices on it are in some sense real amba devices.  The problem is
> >>>>that not all of the devices on the bus implement peripheral ID
> >>>>registers or other mechanisms that good upstanding AMBA devices are
> >>>>expected to have.
> >>>
> >>>Before we go hardware bashing of non primecell AMBA devices I would just
> >>>want to point out that the primecell stuff is not part of the AMBA
> >>>specification.
> >>
> >>And before we go down that route, let me point out that the 'amba bus'
> >>stuff in the kernel is there to support primecells, rather than all
> >>devices which the AMBA specification covers.
> >>
> >>The reason it's called 'amba' is because back in 2001 or so when the
> >>first primecell drivers were created, there was little information
> >>available as to what AMBA, AHB, or APB even covered.  All I had to go
> >>on were the primecell documents themselves.  The higher level documents
> >>were not available to me.
> >>
> >>So, despite it being called 'amba', it really is just for primecells
> >>and if we didn't have the exposure to userspace, I'd have renamed it to
> >>'apb' or similar instead.
> >
> >Okay, that clarifies things a lot, and lends weight to the arguement
> >that it is perfectly normal and acceptable to have both amba_devices
> >and platform_devices on the same bus segment.  Are there any cases
> >where amba primecells are being driven by platform_drivers?  If so,
> >should those drivers have an amba_driver registration added?
> 
> I would be surprised if there are any implemented as
> platform_drivers that are not duplicates of an amba driver. The STMP
> uart is actually a pl011 and it's platform driver was recently

It (duart than auart) is a platform driver in Freesccale BSP, and was
turned into 'amba' one when being upstreamed.

> removed IIRC. So I think we can consider platform drivers something
> that should be fixed in this case.
> 

-- 
Regards,
Shawn
