From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Dec 2015 10:14:00 +0100
Subject: [PATCH] ASoC: sun4i: Implement MIC1 capture
In-Reply-To: <20151130161705.GY1929@sirena.org.uk>
References: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
 <20151130161705.GY1929@sirena.org.uk>
Message-ID: <20151201091400.GD29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 30, 2015 at 04:17:05PM +0000, Mark Brown wrote:
> On Mon, Nov 30, 2015 at 04:37:47PM +0100, Maxime Ripard wrote:
> 
> A couple of minor issues below but I'll apply this - please send
> followup patches.
> 
> > +static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
> > +{
> > +	/*
> > +	 * FIXME: according to the BSP, we might need to drive a PA
> > +	 *        GPIO high here on some boards
> > +	 */
> 
> That's not something this driver needs to worry about, that's something
> the machine driver will do - the whole purpose is to glue all the
> different components on the board together.

Indeed, I'll remove the comment.

> 
> > +	if (clk_set_rate(scodec->clk_module, clk_freq))
> > +		return -EINVAL;
> 
> It'd be better to pass back the error code from clk_set_rate().

Ack, I'll send a patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/23d528a7/attachment.sig>
