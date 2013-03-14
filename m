From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 14 Mar 2013 13:55:45 +0100
Subject: [PATCH 07/10] ASoC: phycore-ac97: Add DT support
In-Reply-To: <20130312185921.GX19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-8-git-send-email-mpa@pengutronix.de>
 <20130312185921.GX19942@opensource.wolfsonmicro.com>
Message-ID: <20130314125545.GD32452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 06:59:22PM +0000, Mark Brown wrote:
> On Sun, Mar 10, 2013 at 07:33:08PM +0100, Markus Pargmann wrote:
> > Add devicetree support for this audio soc fabric driver.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  sound/soc/fsl/phycore-ac97.c | 148 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 125 insertions(+), 23 deletions(-)
> 
> A binding document is mandatory for new bindings.
> 
> > +#ifdef CONFIG_MACH_IMX27_DT
> > +		.cpu_dai_name	= "10010000.ssi",
> > +		.platform_name	= "imx-fiq-pcm-audio",
> > +#else
> 
> This looks wrong, at least the CPU DAI name should be being looked up
> via the DT.

Yes.

> 
> > +static const struct of_device_id imx_phycore_ac97_of_dev_id[] = {
> > +	{
> > +		.compatible = "phytec,imx27-pca100-ac97",
> > +		.data = (void *)MX27_PCA100,
> > +	}, {
> > +		.compatible = "phytec,imx27-pcm043-ac97",
> > +		.data = (void *)MX27_PCM043
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_phycore_ac97_of_dev_id);
> 
> It seems like we ought to be able to describe the properties of the
> boards in this class rather than just enumerating the boards.  What are
> the differences?

All right I will change it. They are actually using different audmux
port configuration.

> 
> >  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> > -MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
> > +MODULE_DESCRIPTION(DRV_NAME ": PhyCORE ALSA SoC fabric driver");
> 
> Please don't make up terms like "fabric driver".

I didn't make it up. There are actually other drivers with that name,
like "mpc5200 pcm030 fabric driver" or "mpc5200 Efika fabric driver"
which actually do the same as this one.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
