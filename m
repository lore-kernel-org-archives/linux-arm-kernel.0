From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jul 2013 09:04:37 +0100
Subject: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <20130706171323.GG16871@s25.your-server.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
 <20130703160637.GQ27646@sirena.org.uk>
 <20130706171323.GG16871@s25.your-server.de>
Message-ID: <20130708080437.GM27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 07:13:23PM +0200, Markus Pargmann wrote:
> On Wed, Jul 03, 2013 at 05:06:37PM +0100, Mark Brown wrote:
> > On Thu, Jun 20, 2013 at 03:20:23PM +0200, Markus Pargmann wrote:

> > > +	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");

> > This binding should be documented.  I'm not sure it really needs to be
> > a binding, though - is it not possible for the driver to just figure out
> > that DMA won't work automatically (for example by looking at the CODEC
> > in use)?  I'm not sure this is a good name either, it should be saying
> > why the FIQ is needed rather than saying that we should use the FIQ.

> I think fsl_ssi_startup is the first function in which we know which
> codec is connected to fsl-ssi. There we have access to the pcm runtime,
> which stores the codec used. But that is too late for the ssi setup.

> I could use of_find_compatible_node to search for the wm9712 codec, but
> that would assume that there is only one codec attached to the system.

If the SSI is doing anything it will be connected to a CODEC.  If it's
not connected to a CODEC then it doesn't need to be configured at all so
it doesn't really matter.

> Perhaps "fsl,fiq-filter-codec-stream" is a better name for the binding?

Possibly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/45225acd/attachment.sig>
