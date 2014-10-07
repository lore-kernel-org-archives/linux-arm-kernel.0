From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 7 Oct 2014 15:05:03 +0200
Subject: [PATCH 2/5] regulator: Set ena_gpio_valid in regulator drivers
In-Reply-To: <20141007115817.GX4609@sirena.org.uk>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-3-git-send-email-mpa@pengutronix.de>
 <20141007115817.GX4609@sirena.org.uk>
Message-ID: <20141007130503.GG5042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 07, 2014 at 12:58:17PM +0100, Mark Brown wrote:
> On Mon, Oct 06, 2014 at 10:17:12PM +0200, Markus Pargmann wrote:
> > This patch sets the new field ena_gpio_valid for all drivers which set a
> > valid ena_gpio.
> 
> >  	config.ena_gpio = arizona->pdata.ldoena;
> > +	config.ena_gpio_valid = true;
> 
> This patch just unconditionally sets the flag in all drivers which will
> break any system which relies on the existing behaviour that we ignore
> GPIO 0.  We can definitely set this flag in any DT only system if we get
> the GPIO from DT but otherwise doing this defeats the point of having
> the flag in the first place.

Right, I didn't thought about the old platform data which may pass 0
gpios indicating that there is no gpio.
I will rework this patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/250132db/attachment.sig>
