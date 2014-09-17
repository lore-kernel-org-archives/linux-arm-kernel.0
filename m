From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 17 Sep 2014 10:55:56 +0200
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <20140917084120.GA6369@Robin-OptiPlex-780>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
 <1410774073.3314.1.camel@pengutronix.de>
 <20140916034123.GA20800@Robin-OptiPlex-780>
 <1410861006.2746.1.camel@pengutronix.de>
 <20140917084120.GA6369@Robin-OptiPlex-780>
Message-ID: <1410944156.2731.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 17.09.2014, 16:41 +0800 schrieb Robin Gong:
> On Tue, Sep 16, 2014 at 11:50:06AM +0200, Lucas Stach wrote:
> > Hi Robin,
> > 
> > Am Dienstag, den 16.09.2014, 11:41 +0800 schrieb Robin Gong:
> > > Hi Lucas,
> > >   I understood your concern,but looks we have to break old DT.
> > 
> > Sorry, but this isn't going to happen. And honestly I don't even see the
> > need to do so.
> > 
> > > Our old DT
> > > support SPI DMA on i.mx6q/dl(v2,b3810c3dc1bcbc6a), but the DMA support patch
> > > for SPI driver is still in reviewing(v6).
> > 
> > So this means now is the time to fix this driver patch to not enable DMA
> > on imx6dl. Nobody will experience any breakage in this case.
> >
> Sorry, i.mx6q and i.mx6dl are totally same, not only IP but also clock. So we
> can't distinguish them except for different compatible name....

I know that, but I still don't see the problem.

If this issue is specific to the ECSPI IP integrated into a imx6dl SoC
you need to check for the machine compatible in the driver and disable
DMA support based on this. We generally avoid checking for the machine
compatible in drivers and prefer to have a specific IP block compatible
instead, but in that case it's the only reasonable thing to do.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
