From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 1 Apr 2010 10:02:23 +0200
Subject: [PATCH] ARM: MXC: mxcmmc: Teach the driver SDIO operations
In-Reply-To: <w2me2d7436a1003311034td3af4a49pdb1ac003a7d31c7d@mail.gmail.com>
References: <m2ke2d7436a1003310941t18aeab59qb41f96bc58618960@mail.gmail.com>
	<1270055079-30998-1-git-send-email-daniel@caiaq.de>
	<w2me2d7436a1003311034td3af4a49pdb1ac003a7d31c7d@mail.gmail.com>
Message-ID: <20100401080223.GI30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 07:34:14PM +0200, Micha? Miros?aw wrote:
> 2010/3/31 Daniel Mack <daniel@caiaq.de>:
> > Successfully tested on MX31 hardware using libertas SDIO peripherals.
> >
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Volker Ernst <volker.ernst@txtr.com>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > ---
> > ?drivers/mmc/host/mxcmmc.c | ? 62 +++++++++++++++++++++++++++++++++++++-------
> > ?1 files changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> > index 44a53ee..f91a2c3 100644
> > --- a/drivers/mmc/host/mxcmmc.c
> > +++ b/drivers/mmc/host/mxcmmc.c
> > @@ -119,6 +119,7 @@ struct mxcmci_host {
> > ? ? ? ?int ? ? ? ? ? ? ? ? ? ? detect_irq;
> > ? ? ? ?int ? ? ? ? ? ? ? ? ? ? dma;
> > ? ? ? ?int ? ? ? ? ? ? ? ? ? ? do_dma;
> > + ? ? ? int ? ? ? ? ? ? ? ? ? ? use_sdio;
> > ? ? ? ?unsigned int ? ? ? ? ? ?power_mode;
> > ? ? ? ?struct imxmmc_platform_data *pdata;
> >
> 
> This field should be protected by the same spinlock as it is used to
> set the reg's value.

Ok - I'll repost all three patches.

Again, thanks for your review.

Daniel
