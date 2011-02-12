From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Feb 2011 14:16:50 +0530
Subject: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP boot
	failure)
In-Reply-To: <cace62268ad657586f07ecbb0e6a99ab@mail.gmail.com>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk>
	<20110106182023.GV7771@atomide.com>
	<20110106203238.GH1198@n2100.arm.linux.org.uk>
	<20110106204053.GA7771@atomide.com>
	<20110107161230.GR1198@n2100.arm.linux.org.uk>
	<20110110185209.GC4957@atomide.com>
	<20110111231611.GX4957@atomide.com>
	<3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
	<20110202011006.GP3358@atomide.com>
	<81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
	<20110202194855.GA3322@atomide.com>
	<cace62268ad657586f07ecbb0e6a99ab@mail.gmail.com>
Message-ID: <84fafb82318b1287513d198c6535eb59@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Thursday, February 03, 2011 2:13 PM
> To: Tony Lindgren
> Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> kernel at lists.infradead.org; linux-omap at vger.kernel.org; Keshava
> Munegowda; Felipe Balbi
> Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> 4430SDP boot failure)
>
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Thursday, February 03, 2011 1:19 AM
> > To: Santosh Shilimkar
> > Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> > kernel at lists.infradead.org; linux-omap at vger.kernel.org; Keshava
> > Munegowda; Felipe Balbi
> > Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> > 4430SDP boot failure)
> >
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110201 22:04]:
> > > >
> > > > It's a ES1.0 blaze, with the patch below it reboots early
> > > > during the boot. I also have to disable omap_l2_cache_init
> > > > on this board to get it to boot.
> > > >
> > > Do you still get this problem with 'omap_l2_cache_init' ?
> > > As reported earlier, we don't see this issue on ES1.0
> > > SDP.
> >
> > Yeah I do, it rarely makes it to the userspace. Works reliably
> > if I disable omap_l2_cache_init.
> >
> Ok. I shall try few experiments and try to reproduce it

Not sure if it's the same issue but I managed to reproduce the
issue on ES2.0 itself. And after some experiments, it boiled
down to the V6 and V7 issue. By disabling OMAP2 from the build,
everything was fine again.

Regards,
Santosh
