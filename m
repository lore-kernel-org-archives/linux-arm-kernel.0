From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 28 Mar 2012 01:23:56 -0400 (EDT)
Subject: [PATCH 1/2] ARM: lib: Add optimized memcpy with 64 byte pld size
In-Reply-To: <013501cd0c79$c1e244e0$45a6cea0$%kim@samsung.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <00cf01cd0bb0$4fa49c30$eeedd490$%kim@samsung.com>
 <alpine.LFD.2.02.1203262231220.24151@xanadu.home>
 <013501cd0c79$c1e244e0$45a6cea0$%kim@samsung.com>
Message-ID: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Mar 2012, Boojin Kim wrote:

> Nicolas wrote:
> 
> > This creates quite convoluted code.  If this is worth doing, we'll have
> > to find a cleaner way to do this.
> >
> > Could you please provide performance measurement numbers with and
> > without this patch, and similarly for the next patch?
> >
> > Did you try enabling the cache alignment code?  What performance
> > difference if any did you see?
> My patch brings about 10% better result on cache boundary.
> 64bytes PLD size makes the cache efficiency be higher on machines that has 64byte cache line.
> And, Which one is convoluted code? Can you explain it more detail?

Yes, I will.  I now have reworked this code to be extensible and still 
as clean as possible.  I'm not going to post it right away though, given 
that it is late and I prefer to have another look at it after I had some 
sleep.


Nicolas
