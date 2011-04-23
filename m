From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 24 Apr 2011 09:26:21 +1000
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211147300.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<4DAFD5AA.9020404@codeaurora.org>
	<alpine.LFD.2.02.1104211147300.3323@ionos>
Message-ID: <1303601181.2513.132.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-21 at 12:33 +0200, Thomas Gleixner wrote:
> 
> Depends, there is a lot of sane hardware out there (not necessarily in
> the ARM SoC world). We can do with a pointer if the need arises.
>  
> > >     optionally a set of common register accessor functions like I did
> > >     for the generic irq chip.
> > 
> > Again, I don't see the point in having this in the common code. May be I'm
> > missing something?
> 
> See my RFC patch of a generic irq chip implementation and how much
> duplicated five line inline functions they removed.
>  
> > IMO, a better option instead of the base register and the offsets would be an
> > option to have a priv_data pointer. I forgot the exact use case, but we
> > thought that would have been helpful when we tried to port the msm clock
> > driver in our tree on top of Jeremy's patches.
> 
> It works either way, but we should try to comeup with a sensible
> common base struct for sane hardware. 

Doesn't have to be in the base struct tho. I think a better approach is
to keep the base struct reasonably API-only, and have an
"implementation" subclass called something like simple_clk for example,
that carries those few fields common to most MMIO based implementation
and which can be created with existing "helper" code for the most common
ones.

Ben.
