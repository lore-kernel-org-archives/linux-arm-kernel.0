From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 10:39:22 +0800
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <201209050346.39253.marex@denx.de>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
 <20120905014000.GP2362@S2101-09.ap.freescale.net>
 <201209050346.39253.marex@denx.de>
Message-ID: <20120905023919.GQ2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 03:46:39AM +0200, Marek Vasut wrote:
> Let me ask about another thing. If there'll eventually be some device that'd 
> need even larger transfer (say ... hundreds of megs) we'd end up with trouble 
> again.
> 
> One way to fix this is to recycle descriptors that were already used during the 
> transfer, but can we really do it fast enough, so the DMA would do it's job at 
> one end of the descriptor chain and we'd be building the other?
> 
It looks like a solution, but I'm not sure if it works either.

Regards,
Shawn

> The other (easier) way is to let the device that claims the particular DMA 
> channel allocate as much descriptors as it might ever need, which I think is 
> wrong.
> 
> What do you think ?
> 
> Best regards,
> Marek Vasut
