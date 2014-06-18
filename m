From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Jun 2014 23:19:33 +0200
Subject: [PATCH v11 2/8] ASoC: core: Generic ac97 link reset functions
In-Reply-To: <20140618184234.GA27312@sfrouter>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
 <20140618184234.GA27312@sfrouter>
Message-ID: <20140618211933.GD32450@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Silvio,

On Wed, Jun 18, 2014 at 08:42:34PM +0200, S. Fricke wrote:
> 
> Hi Markus,
> 
> I'm fighting with your ac97 pinctrl configuration per dts. 
> 
> > [...]
> > +ssi {
> > +	...
> > +
> > +	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";
> > +	pinctrl-0 = <&ac97link_running>;
> > +	pinctrl-1 = <&ac97link_running>;
> > +	pinctrl-2 = <&ac97link_reset>;
> > +	pinctrl-3 = <&ac97link_warm_reset>;
> > +	ac97-gpios = <&gpio3 20 0 &gpio3 22 0 &gpio3 28 0>;
> 
> I see here the gpios for sync, sdata and reset. On my board I have two sdata
> lines (sdata-in and sdata-out) which line should I specify here for this setting?

Try to use sdata-out. This is the only data output line. sdata-in is the
input to the SoC so we don't have to use this for an AC97 reset.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/5abd42f4/attachment.sig>
