From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Sep 2012 04:57:54 +0200
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <20120905023919.GQ2362@S2101-09.ap.freescale.net>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
 <201209050346.39253.marex@denx.de>
 <20120905023919.GQ2362@S2101-09.ap.freescale.net>
Message-ID: <201209050457.54336.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Wed, Sep 05, 2012 at 03:46:39AM +0200, Marek Vasut wrote:
> > Let me ask about another thing. If there'll eventually be some device
> > that'd need even larger transfer (say ... hundreds of megs) we'd end up
> > with trouble again.
> > 
> > One way to fix this is to recycle descriptors that were already used
> > during the transfer, but can we really do it fast enough, so the DMA
> > would do it's job at one end of the descriptor chain and we'd be
> > building the other?
> 
> It looks like a solution, but I'm not sure if it works either.

Besides ... if the system is under some heavier load, this might crash too.

Best regards,
Marek Vasut
