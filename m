From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 09:20:39 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <20110107120802.GA2354@sortiz-mobl>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
	<20110103154214.GB11033@pengutronix.de>
	<20110107120802.GA2354@sortiz-mobl>
Message-ID: <20110131082039.GK9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Fri, Jan 07, 2011 at 01:08:03PM +0100, Samuel Ortiz wrote:
> Hi Sascha,
> 
> On Mon, Jan 03, 2011 at 04:42:14PM +0100, Sascha Hauer wrote:
> > On Mon, Dec 20, 2010 at 11:48:41AM +0100, Sascha Hauer wrote:
> > > The IPU is the Image Processing Unit found on i.MX50/51/53 SoCs. It
> > > features several units for image processing, this patch adds support
> > > for the units needed for Framebuffer support, namely:
> > >
> > > - Display Controller (dc)
> > > - Display Interface (di)
> > > - Display Multi Fifo Controller (dmfc)
> > > - Display Processor (dp)
> > > - Image DMA Controller (idmac)
> > >
> > > This patch is based on the Freescale driver, but follows a different
> > > approach. The Freescale code implements logical idmac channels and
> > > the handling of the subunits is hidden in common idmac code pathes
> > > in big switch/case statements. This patch instead just provides code
> > > and resource management for the different subunits. The user, in this
> > > case the framebuffer driver, decides how the different units play
> > > together.
> > >
> > > The IPU has other units missing in this patch:
> > >
> > > - CMOS Sensor Interface (csi)
> > > - Video Deinterlacer (vdi)
> > > - Sensor Multi FIFO Controler (smfc)
> > > - Image Converter (ic)
> > > - Image Rotator (irt)
> > >
> > > So expect more files to come in this directory.
> > >
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Hello Samuel,
> > 
> > I see no further comments on this series. Does this mean you are ok with
> > the patch or didn't you find the time looking at it?
> I'm coming back from my xmas holidays today, and haven't had time to look at
> it yet. Hopefully next week.

Ping. I'd like to get this into the next merge window. Right now there
is still enough time for me to react on comments.

Regards,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
