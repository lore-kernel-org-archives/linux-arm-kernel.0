From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Jun 2010 09:56:56 +0100
Subject: [PATCH] ARM: RealView: Do not use outer_sync() on certain with
	L210/L220
In-Reply-To: <AANLkTinpAz52QfsnvzIY5fleJoflVr0Z40JpRNrlXY9k@mail.gmail.com>
References: <20100629093135.10365.99959.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTinpAz52QfsnvzIY5fleJoflVr0Z40JpRNrlXY9k@mail.gmail.com>
Message-ID: <1277888217.13942.0.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-30 at 09:13 +0100, Linus Walleij wrote:
> 2010/6/29 Catalin Marinas <catalin.marinas@arm.com>:
> 
> > RealView boards with certain revisions of the L210/L220 cache controller
> > may have issues (hardware deadlock) with the recent changes to the mb()
> > barrier implementation (DSB followed by an L2 cache sync). The patch
> > disables ARM_DMA_MEM_BUFFERABLE for the RealView boards with L210/L220
> > and redefines the mandatory barriers without the outer_sync() call.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Linus Walleij <linus.ml.walleij@gmail.com>
> 
> Works like a charm on the PB1176!
> 
> Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Thanks for testing. Just to be sure - was this with the CACHE_L2X0
enabled in your configuration?

-- 
Catalin
