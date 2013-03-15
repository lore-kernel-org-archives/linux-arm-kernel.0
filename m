From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 15 Mar 2013 10:07:03 +0100
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT
 DMA request
In-Reply-To: <20130315034246.GA18039@S2101-09.ap.freescale.net>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
 <20130313021712.GD27461@S2101-09.ap.freescale.net>
 <20130314130832.GE32452@pengutronix.de>
 <20130315034246.GA18039@S2101-09.ap.freescale.net>
Message-ID: <20130315090703.GB22650@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 11:42:48AM +0800, Shawn Guo wrote:
> On Thu, Mar 14, 2013 at 02:08:32PM +0100, Markus Pargmann wrote:
> > On Wed, Mar 13, 2013 at 10:18:29AM +0800, Shawn Guo wrote:
> > > On Tue, Mar 12, 2013 at 07:02:07PM +0000, Mark Brown wrote:
> > > > On Sun, Mar 10, 2013 at 07:33:09PM +0100, Markus Pargmann wrote:
> > > > > Add a function to open a DMA PCM substream using devicetree data
> > > > > provided via the client device node. The patch introduces a public
> > > > > function and a private subfunction that is called by both open
> > > > > functions.
> > > > 
> > > > Someone (I think it was Shawn) sent a very similar patch just recently
> > > > which appears to have fallen out of my inbox unfortunately - can you
> > > > please check what's going on there and coordinate with them?  Let me
> > > > know if you can't find the patch and I'll dig it out.
> > > 
> > > It's here, Markus.
> > > 
> > > http://thread.gmane.org/gmane.linux.alsa.devel/106027/focus=106031
> > > 
> > 
> > Thanks. Do you already have a patch for the non-generic function which I
> > could use instead?
> > 
> I do not follow.  With my patch in place, there will be two
> dmaengine_pcm APIs.
> 
> int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
>         dma_filter_fn filter_fn, void *filter_data)
> 
> int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
>                                    struct device *dev, const char *name)
> 
> The first one is for users that their dmaengine driver hasn't converted
> to generic device tree bindings, and the second one is for users that
> their dmaengine driver is converted to generic device tree bindings.

Sorry, I mixed up different patch versions and was confused.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
