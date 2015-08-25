From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Aug 2015 12:22:10 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <55DC40C1.3050405@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de> <55DC40C1.3050405@atmel.com>
Message-ID: <201508251222.10813.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 25, 2015 at 12:17:37 PM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

> Le 24/08/2015 13:03, Marek Vasut a ?crit :
> > On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
> >> This driver add support to the new Atmel QSPI controller embedded into
> >> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> >> controller.
> >> 
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> >> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Hi,
> > 
> > [...]
> > 
> >> +/* Register access macros */
> > 
> > These are functions, not macros :)
> > 
> > btw is there any reason for these ? I'd say, just put the read*() and
> > write*() functions directly into the code and be done with it, it is
> > much less confusing.
> 
> If you don't mind, I'd rather keep some of these inline functions. I have
> no strong justification, it's more a personal taste: it makes lines
> shorter as it avoids the need to add "->regs + ".
> Also it makes the code consistent with other Atmel drivers which already
> use such wrappers.
> 
> However I'll fix the comment and remove the byte and word versions, which
> are not used. So only qspi_readl() and qspi_writel() are left.
> 
> Does it sound good to you?

In my mind, seeing explicit readl_relaxed() somewhere is much easier to
digest than seeing some wrapper, which I have to look up. But please do
wait for others to voice their concern too, I might not be the best person
to tell you what to do when it comes to wrapping IO accessors ;-)

Best regards,
Marek Vasut
