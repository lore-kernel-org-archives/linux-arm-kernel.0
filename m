From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 23:02:06 +0100
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <20160113215013.GS109450@google.com>
References: <9019174.GYajdpGP8V@wuerfel> <20160113215013.GS109450@google.com>
Message-ID: <5830403.0pR8UVXPRZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 13:50:13 Brian Norris wrote:
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
> > index 220ddfcf29f5..dbc5b571c2bb 100644
> > --- a/drivers/mtd/nand/nuc900_nand.c
> > +++ b/drivers/mtd/nand/nuc900_nand.c
> > @@ -113,7 +113,7 @@ static int nuc900_check_rb(struct nuc900_nand *nand)
> >  {
> >       unsigned int val;
> >       spin_lock(&nand->lock);
> > -     val = __raw_readl(REG_SMISR);
> > +     val = __raw_readl(nand->reg + REG_SMISR);
> >       val &= READYBUSY;
> >       spin_unlock(&nand->lock);
> >  
> 
> Looks OK to me, though I kinda hate dragging on support for
> obviously-unused drivers...

Should we mark that driver in Kconfig as obviously broken then?

Let's wait for Wan ZongShun to reply first, it's possible that the
entire w90x900 platform has come to the point where we are better off
removing it than fixing ancient bugs.

	Arnd
