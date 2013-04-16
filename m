From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 16 Apr 2013 17:23:05 +0200
Subject: [PATCH v3 05/15] ASoC: phycore-ac97: Add DT support
In-Reply-To: <20130416115942.GG26958@opensource.wolfsonmicro.com>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
 <20130416115942.GG26958@opensource.wolfsonmicro.com>
Message-ID: <20130416152305.GE13272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 12:59:43PM +0100, Mark Brown wrote:
> On Sun, Apr 14, 2013 at 01:42:49PM +0200, Markus Pargmann wrote:
> 
> > +	/*
> > +	 * This driver doesn't need to know which actual hardware is used.
> > +	 * The audmux driver has knowledge about it's type, and returns
> > +	 * an error if executed on the wrong type of hardware.
> > +	 */
> > +	ret = phycore_ac97_pca100_audmux();
> > +	if (!ret)
> > +		return 0;
> > +
> > +	ret = phycore_ac97_pcm043_audmux();
> 
> The DT really ought to be able to give enough information to figure out
> the audmux configuration.  If we can't do that it rather defeats the
> point of moving to DT...

Yes you are right, I added a phandle "phytec,audmux" to check which
audmux setup function we have to use.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
