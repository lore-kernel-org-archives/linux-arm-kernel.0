From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jun 2016 09:36:43 +0200
Subject: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
In-Reply-To: <20160610003755.GC7510@sirena.org.uk>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <20160602102651.GF2282@sirena.org.uk>
 <20160609210515.GI5242@lukather>
 <20160610003755.GC7510@sirena.org.uk>
Message-ID: <20160610073643.GK5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Jun 10, 2016 at 01:37:55AM +0100, Mark Brown wrote:
> > > > +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> > > > +{
> > > > +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> 
> > > > +	/* Enable the whole hardware block */
> > > > +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > > +		     SUN4I_I2S_CTRL_GL_EN);
> 
> > > Runtime PM?  It also seems like this is something that ought to be
> > > covered in the suspend and resume callbacks.
> 
> > runtime_pm is supported, and uses the regmap cache to keep those
> > changes.
> 
> No, my point is that I'd expect to see the block powered off on suspend.

It is. The bus clock is disabled, which also puts the IP in reset.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/9fe2b624/attachment.sig>
