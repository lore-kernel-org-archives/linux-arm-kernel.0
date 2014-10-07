From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 12:58:17 +0100
Subject: [PATCH 2/5] regulator: Set ena_gpio_valid in regulator drivers
In-Reply-To: <1412626635-7404-3-git-send-email-mpa@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20141007115817.GX4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 10:17:12PM +0200, Markus Pargmann wrote:
> This patch sets the new field ena_gpio_valid for all drivers which set a
> valid ena_gpio.

>  	config.ena_gpio = arizona->pdata.ldoena;
> +	config.ena_gpio_valid = true;

This patch just unconditionally sets the flag in all drivers which will
break any system which relies on the existing behaviour that we ignore
GPIO 0.  We can definitely set this flag in any DT only system if we get
the GPIO from DT but otherwise doing this defeats the point of having
the flag in the first place.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/bf5c95df/attachment.sig>
