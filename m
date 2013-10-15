From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 Oct 2013 12:09:32 +0200
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <20131015100025.GX25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
 <20131014173824.GT25034@n2100.arm.linux.org.uk>
 <CAOMZO5BRmXav-qj4DqvTJASfU98sJ3zpHHZBk7s4pCkDd0Z85Q@mail.gmail.com>
 <20131015100025.GX25034@n2100.arm.linux.org.uk>
Message-ID: <20131015100931.GH30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 11:00:26AM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 14, 2013 at 11:47:17PM -0300, Fabio Estevam wrote:
> > On Mon, Oct 14, 2013 at 2:38 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > 
> > > Shouldn't the above be in patch 1 (or 1.5) rather than patch 2?  Patch 2
> > > advertises itself as adding support for the wandboard, but in actual
> > > fact it's adding the generic bits too.
> > 
> > Thanks for your review. Will address your comments in v3.
> > 
> > Philipp Zabel mentioned that he will move imx-drm out of staging, so
> > will send v3 after Philipp's patch gets into linux-next.
> 
> That's unfortunate, especially given the bug with the clock polarity
> (which, although I can tweak the register directly, it's not obvious
> that changing the clk_pol initialisation is the correct solution.)
> 
> There's also another issue here: the lack of DRM prime support.  As
> you have a separate GPU and separate VPU, you really need dmabuf
> support implemented so that you can hand your scanout buffers/overlays
> to other subsystems.

See http://www.spinics.net/lists/linux-driver-devel/msg39324.html

Besides other things this adds prime support.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
