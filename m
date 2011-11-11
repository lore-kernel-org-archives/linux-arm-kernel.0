From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 11 Nov 2011 16:13:41 +0100
Subject: [PATCH v2] mmc mxcmmc: fix falling back to PIO
In-Reply-To: <20111111144815.GW16886@pengutronix.de>
References: <1314264785-19224-1-git-send-email-s.hauer@pengutronix.de>
 <20111111144815.GW16886@pengutronix.de>
Message-ID: <20157.15269.398865.274711@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> Hi Chris,
> 
> Can you take this one please?
> 
> Sascha
> 
> On Thu, Aug 25, 2011 at 11:33:05AM +0200, Sascha Hauer wrote:
> > When we can't configure the dma channel we want to fall
> > back to PIO. We do this by setting host->do_dma to zero.
> > This does not work as do_dma is used to see whether dma
> > can be used for the current transfer. Instead, we have
> > to set host->dma to NULL.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc at vger.kernel.org
> > ---
> >  drivers/mmc/host/mxcmmc.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> > index 14aa213..4dc9008 100644
> > --- a/drivers/mmc/host/mxcmmc.c
> > +++ b/drivers/mmc/host/mxcmmc.c
> > @@ -730,7 +730,8 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  			dev_err(mmc_dev(host->mmc),
> >  				"failed to config DMA channel. Falling back to PIO\n");
> >  			dma_release_channel(host->dma);
> > -			host->do_dma = 0;
> > +			host->dma = NULL;
> > +			host->dma = 0;
NULL or 0, that is the question? Or both?
That looks a little bit screwed.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
