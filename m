From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 25 Aug 2015 08:57:49 -0700
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <201508251222.10813.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de> <55DC40C1.3050405@atmel.com>
 <201508251222.10813.marex@denx.de>
Message-ID: <20150825155749.GA7622@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 12:22:10PM +0200, Marek Vasut wrote:
> On Tuesday, August 25, 2015 at 12:17:37 PM, Cyrille Pitchen wrote:
> > If you don't mind, I'd rather keep some of these inline functions. I have
> > no strong justification, it's more a personal taste: it makes lines
> > shorter as it avoids the need to add "->regs + ".
> > Also it makes the code consistent with other Atmel drivers which already
> > use such wrappers.
> > 
> > However I'll fix the comment and remove the byte and word versions, which
> > are not used. So only qspi_readl() and qspi_writel() are left.
> > 
> > Does it sound good to you?
> 
> In my mind, seeing explicit readl_relaxed() somewhere is much easier to
> digest than seeing some wrapper, which I have to look up. But please do
> wait for others to voice their concern too, I might not be the best person
> to tell you what to do when it comes to wrapping IO accessors ;-)

I could go either way, but there are times where local wrapper I/O
accessors are useful. Case in point: it makes it really easy to make the
choice between readl() and readl_relaxed() in one place (i.e., the
discussion you had in another branch of this thread). That's been useful
for me on brcmnand, where certain platforms (big-endian MIPS) have
different assumptions about endianness than your average platform. Also,
it helps with things like what Robert Jarzmik is trying to do on
pxa3xx_nand -- add debug info to print every register read/write.

Also as Cyrille mentioned, personal taste is a factor.

Anyway, I'll go with whatever makes sense between y'all. I don't mind.

Brian
