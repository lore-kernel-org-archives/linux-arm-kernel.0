From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 3 Nov 2014 14:22:19 +0100
Subject: [PATCH v2 2/4] regulator: Set ena_gpio_initialized in regulator
 drivers
In-Reply-To: <20141013144235.GJ27755@sirena.org.uk>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
 <1412776028-15655-3-git-send-email-mpa@pengutronix.de>
 <20141013144235.GJ27755@sirena.org.uk>
Message-ID: <20141103132219.GE24292@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the delay, holiday and so on.

On Mon, Oct 13, 2014 at 04:42:35PM +0200, Mark Brown wrote:
> On Wed, Oct 08, 2014 at 03:47:06PM +0200, Markus Pargmann wrote:
> 
> > --- a/drivers/regulator/max8952.c
> > +++ b/drivers/regulator/max8952.c
> > @@ -225,6 +225,8 @@ static int max8952_pmic_probe(struct i2c_client *client,
> >  	config.of_node = client->dev.of_node;
> >  
> >  	config.ena_gpio = pdata->gpio_en;
> > +	if (!pdata)
> > +		config.ena_gpio_initialized = true;
> 
> This looks wrong, we're checking for pdata being non-NULL immediately
> after dereferencing pdata.

Yes this is wrong, I changed it to check for client->dev.of_node instead.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/c2dab7f2/attachment.sig>
