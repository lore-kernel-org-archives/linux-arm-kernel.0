From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 15:44:52 +0200
Subject: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT bindings
In-Reply-To: <20130727115950.GF9858@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
 <20130727115950.GF9858@sirena.org.uk>
Message-ID: <20130727134452.GF16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 12:59:50PM +0100, Mark Brown wrote:
> On Sat, Jul 27, 2013 at 01:31:51PM +0200, Markus Pargmann wrote:
> 
> > +static const struct of_device_id wm9712_codec_of_dev_id[] = {
> > +	{
> > +		.compatible = "wlf,wm9712",
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +
> >  static struct platform_driver wm9712_codec_driver = {
> >  	.driver = {
> >  		.name = "wm9712-codec",
> >  		.owner = THIS_MODULE,
> > +		.of_match_table = wm9712_codec_of_dev_id,
> >  	},
> >  
> >  	.probe = wm9712_probe,
> 
> AC'97 is an enumerable bus, we shouldn't need this...

What do you mean exactly? Is there a way to automaticaly discover
connected codecs and register them?

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
