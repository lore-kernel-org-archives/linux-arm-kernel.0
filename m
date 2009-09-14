From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2009 09:10:01 +0100
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <20090914002100.GD30621@shareable.org>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<200909132328.47079.marek.vasut@gmail.com>
	<20090913230008.GC30169@n2100.arm.linux.org.uk>
	<20090914002100.GD30621@shareable.org>
Message-ID: <20090914081001.GB14519@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 01:21:00AM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > On Sun, Sep 13, 2009 at 11:28:47PM +0200, Marek Vasut wrote:
> > > >  		bhi	__delay
> > > >  		mov	pc, lr
> > > >  ENDPROC(__udelay)
> > > > 
> > > Hi
> > > 
> > > why was this code there in the first place ?
> > 
> > To make the delay loop more stable and predictable on older CPUs.
> 
> So why has it been commented out, if it's needed for that?

We moved on and it penalises later CPUs, leading to udelay providing
shorter delays than requested.

So the choice was either stable and predictable on older CPUs but
buggy on newer CPUs, or correct on all CPUs but gives unnecessarily
longer delays on older CPUs.
