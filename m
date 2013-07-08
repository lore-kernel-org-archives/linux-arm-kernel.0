From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jul 2013 09:06:22 +0100
Subject: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
In-Reply-To: <20130707071949.GH16871@s25.your-server.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
 <20130703161727.GS27646@sirena.org.uk>
 <20130707071949.GH16871@s25.your-server.de>
Message-ID: <20130708080622.GN27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 07, 2013 at 09:19:49AM +0200, Markus Pargmann wrote:
> On Wed, Jul 03, 2013 at 05:17:27PM +0100, Mark Brown wrote:

> > > +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> > > +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> > > +#else
> > > +static void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > > +static void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }

> > These functions have no reason to be anywhere except in the driver and
> > really you should just be specifying which pins to use there - ideally
> > via pinctrl but I don't think i.MX has adopted that yet.

> There are no pinctrl driver for imx27(pca100) or imx35(pcm043). The
> iomux/pad configure functions are defined inside mach-imx/ including
> their headers. Both reset functions have to configure iomux/pad before
> and after using gpio. So I think it's not possible to make the reset
> based on the gpio pins without the necessary iomux/pad configuration.

That all sounds fixable - either make pinctrl available or make the
headers usefully visible.  You can see the arch headers in the build
of the entire kernel...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/f61f4aec/attachment.sig>
