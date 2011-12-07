From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 20:16:04 +0800
Subject: [MXS MMC 2/5] Some cleanups for the MMC driver
In-Reply-To: <20191.21688.696997.76000@ipc1.ka-ro>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
 <20111207120120.GK5550@S2100-06.ap.freescale.net>
 <20191.21688.696997.76000@ipc1.ka-ro>
Message-ID: <20111207121603.GL5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 12:57:44PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > I'm fine with this cosmetic patch with the comments below addressed.
> > 
> > On Tue, Dec 06, 2011 at 02:41:27PM +0100, Lothar Wa?mann wrote:
> > >  - Remove bogus parens around numerical arguments in #define's
> > >  - When defining bit masks, use the #def for the shift count
> > >    instead of repeating the numbers
> > 
> > This change brings a few 'line over 80 characters' checkpatch warnings.
> > 
> will fix.
> 
> > >  - Remove bogus whitespace in indentation
> > >  - Remove 'break' at end of switch statement
> > > 
> > > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > > ---
> > >  drivers/mmc/host/mxs-mmc.c |   57 +++++++++++++++++++++----------------------
> > >  1 files changed, 28 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > [...]
> > > @@ -277,7 +277,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
> > >  
> > >  	stat = readl(host->base + HW_SSP_CTRL1);
> > >  	writel(stat & MXS_MMC_IRQ_BITS,
> > > -	       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
> > 
> > This is an intended indentation with 7 spaces.
> > 
> According to Documentation/CodingStyle spaces are never used for
> indentation (except in documentation, Kconfig and comments).
> 
Such nice indentation is all over this driver and even kernel tree.
You may want to leave it as it is or fix them all over the driver.

-- 
Regards,
Shawn
