From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 6 Jul 2013 19:13:23 +0200
Subject: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <20130703160637.GQ27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
 <20130703160637.GQ27646@sirena.org.uk>
Message-ID: <20130706171323.GG16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jul 03, 2013 at 05:06:37PM +0100, Mark Brown wrote:
> On Thu, Jun 20, 2013 at 03:20:23PM +0200, Markus Pargmann wrote:
> 
> > +	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
> > +
> 
> This binding should be documented.  I'm not sure it really needs to be
> a binding, though - is it not possible for the driver to just figure out
> that DMA won't work automatically (for example by looking at the CODEC
> in use)?  I'm not sure this is a good name either, it should be saying
> why the FIQ is needed rather than saying that we should use the FIQ.

I think fsl_ssi_startup is the first function in which we know which
codec is connected to fsl-ssi. There we have access to the pcm runtime,
which stores the codec used. But that is too late for the ssi setup.

I could use of_find_compatible_node to search for the wm9712 codec, but
that would assume that there is only one codec attached to the system.

Perhaps "fsl,fiq-filter-codec-stream" is a better name for the binding?

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
