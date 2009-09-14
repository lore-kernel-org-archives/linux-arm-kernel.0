From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2009 15:40:28 +0100
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <94a0d4530909140738t7e4d646r134cfd884da21348@mail.gmail.com>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<200909132328.47079.marek.vasut@gmail.com>
	<20090913230008.GC30169@n2100.arm.linux.org.uk>
	<20090914002100.GD30621@shareable.org>
	<20090914081001.GB14519@n2100.arm.linux.org.uk>
	<94a0d4530909140558nd8d2c47lc9954563c80a574f@mail.gmail.com>
	<20090914140059.GC21580@n2100.arm.linux.org.uk>
	<94a0d4530909140738t7e4d646r134cfd884da21348@mail.gmail.com>
Message-ID: <20090914144028.GG21580@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 05:38:32PM +0300, Felipe Contreras wrote:
> On Mon, Sep 14, 2009 at 5:00 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Sep 14, 2009 at 03:58:24PM +0300, Felipe Contreras wrote:
> >> On Mon, Sep 14, 2009 at 11:10 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Mon, Sep 14, 2009 at 01:21:00AM +0100, Jamie Lokier wrote:
> >> >> Russell King - ARM Linux wrote:
> >> >> > On Sun, Sep 13, 2009 at 11:28:47PM +0200, Marek Vasut wrote:
> >> >> > > > ? ? ? ? ? ? ? ? bhi ? ? __delay
> >> >> > > > ? ? ? ? ? ? ? ? mov ? ? pc, lr
> >> >> > > > ?ENDPROC(__udelay)
> >> >> > > >
> >> >> > > Hi
> >> >> > >
> >> >> > > why was this code there in the first place ?
> >> >> >
> >> >> > To make the delay loop more stable and predictable on older CPUs.
> >> >>
> >> >> So why has it been commented out, if it's needed for that?
> >> >
> >> > We moved on and it penalises later CPUs, leading to udelay providing
> >> > shorter delays than requested.
> >> >
> >> > So the choice was either stable and predictable on older CPUs but
> >> > buggy on newer CPUs, or correct on all CPUs but gives unnecessarily
> >> > longer delays on older CPUs.
> >>
> >> Why not add an #ifdef CPU_V4 or whatever?
> >
> > Because then you get it whenever you configure for V4 as the lowest
> > denominator CPU, which leads to the buggy behaviour on better CPUs.
> > It's far better to leave it as is and just accept that the old CPUs
> > will have longer than necessary delays. ?If people really really
> > care (and there's likely to only be a small minority of them now)
> > changing the '0' to a '1' is a very simple change for them to carry
> > in their local tree. ?Unlike getting the right unrolling etc.
> 
> Well, they can also 'git revert' this patch. If somebody really cares
> I think they should shout now and provide a better patch, otherwise
> this one should be merged.

On the other hand, having the code there as it currently stands is not
harmful in any way, so leaving it there is just as easy.
