From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Aug 2014 10:12:17 +0200
Subject: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B39787@SW-EX-MBX02.diasemi.com>
References: <1409034367-15228-1-git-send-email-mpa@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B39787@SW-EX-MBX02.diasemi.com>
Message-ID: <20140827081217.GD21770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Tue, Aug 26, 2014 at 03:21:53PM +0000, Opensource [Steve Twiss] wrote:
> 
> On 26 August 2014 07:26, Markus Pargmann wrote
> 
> > Subject: [PATCH v5] watchdog: Add DA9063 PMIC watchdog driver.
> > 
> 
> [...]
> 
> > +
> > +static int da9063_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	mutex_lock(&wdt->lock);
> > +	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > +			DA9063_TWDSCALE_MASK,
> > +			DA9063_TWDSCALE_DISABLE);
> > +	if (ret)
> > +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err = %d)\n",
> > +				ret);
> > +	mutex_unlock(&wdt->lock);
> > +
> > +	return ret;
> > +}
> > +
> 
> Hi Markus,
> 
> A quick typo.
> ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> should probably be wdt->da9063->regmap

yes, thank you. It seems I forgot to execute my checkpatch script before
sending. Sorry, will send a new version.

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/30fdac58/attachment.sig>
