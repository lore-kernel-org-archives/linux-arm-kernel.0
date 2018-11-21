From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Nov 2018 10:52:40 +0100
Subject: [PATCH v2 3/9] phy: Add MIPI D-PHY configuration options
In-Reply-To: <20181119135833.zvgxsl7kwmfewdoa@valkosipuli.retiisi.org.uk>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <b1f6e4c1c3487e1f048cce699a86bcf50f7fed69.1541516029.git-series.maxime.ripard@bootlin.com>
 <20181119135833.zvgxsl7kwmfewdoa@valkosipuli.retiisi.org.uk>
Message-ID: <20181121095240.peq5tpzokdakxvwc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Nov 19, 2018 at 03:58:34PM +0200, Sakari Ailus wrote:
> > +	/**
> > +	 * @clk_pre:
> > +	 *
> > +	 * Time, in nanoseconds, that the HS clock shall be driven by
> > +	 * the transmitter prior to any associated Data Lane beginning
> > +	 * the transition from LP to HS mode.
> > +	 */
> > +	unsigned int		clk_pre;
> 
> Is the unit of clk_pre intended to be UI or ns?

You're right, it's in UI.

> How about adding information on the limits of these values as well?

I usually feel like the more you duplicate informations, the higher
the chances are to do a mistake and that becomes a burden to maintain
over time, but if you feel like it would be best, i'll do it.

> > +	/**
> > +	 * @lanes:
> > +	 *
> > +	 * Number of lanes used for the transmissions.
> > +	 */
> > +	unsigned char		lanes;
> 
> This is related to the data_lanes DT property. I assume this is intended to
> be the number of active lanes. And presumably the first "lanes" number of
> lanes would be used in that case?

I'm not sure I got your question, sorry. But yes, this is the number
of active lanes. In the v4l2 world, chances are that this is going to
come from the data lanes property, in DRM this is coming from the
panel structure.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181121/ceea7fcd/attachment.sig>
