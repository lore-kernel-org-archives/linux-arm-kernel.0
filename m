From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 17 Jan 2011 18:01:31 +0530
Subject: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
In-Reply-To: <1295267193.21557.14.camel@e102109-lin.cambridge.arm.com>
References: <1295265395-28485-1-git-send-email-santosh.shilimkar@ti.com>
	<20110117120104.GB20615@n2100.arm.linux.org.uk>
	<72ca984700f139fea98558783dde38f3@mail.gmail.com>
	<20110117121951.GC20615@n2100.arm.linux.org.uk>
	<1295267193.21557.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <d93218062aa1e6948453d1ddd5b9e2b0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Monday, January 17, 2011 5:57 PM
> To: Russell King - ARM Linux
> Cc: Santosh Shilimkar; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
>
> On Mon, 2011-01-17 at 12:19 +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 17, 2011 at 05:38:11PM +0530, Santosh Shilimkar wrote:
> > > This should be ok. May be Catalin can comment on choice of SGI1
> in
> > > generic smp_cross_call().
> >
> > It's something that came from ARMs early SMP work (in 2002 iirc),
> and
> > was carried forward.  What I don't know is whether there was any
> boot
> > protocol documentation produced which said "you will wait for any
> SGI"
> > or "you will wait for SGI1".
>
> At least on the ARM Ltd platforms, the boot monitor waits for any
> interrupt (it is in WFI). I can't tell about other platforms.
>
Same for OMAP4. Any SGI will do.

Regards,
Santosh
