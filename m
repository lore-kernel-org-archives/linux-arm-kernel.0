From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Sep 2010 15:31:09 +0100
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1282925072.26355.61.camel@e102109-lin.cambridge.arm.com>
References: <1282922978.5075.13.camel@m0nster>
	<1282925072.26355.61.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100904143109.GA16462@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 27, 2010 at 05:04:32PM +0100, Catalin Marinas wrote:
> On Fri, 2010-08-27 at 16:29 +0100, Daniel Walker wrote:
> > > In general, I would have liked a different way (still ID-based) of
> > > handling such issues without duplicating the whole structure. But I see
> > > this becoming the standard as proc-v6.S follows it as well.
> > 
> > This whole thing was something Russell specifically asked for (and
> > practically wrote for me).
> 
> Yes, I know and I'm not saying that you should change it in this patch.
> It's just that I would have liked to only duplicate the setup function
> rather than the whole procinfo structure.

If you think about it, the only way to do that is to make things even
more complicated than they already are by separating out the rest of
the structure from the ID, mask, and setup functions.  At that point,
what if someone has just one change to the other values in the structure?
They'll have the same complaint as you have, and they'll want it split
in an entirely different way.
