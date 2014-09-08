From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 8 Sep 2014 11:25:59 +0200
Subject: [PATCH] mfd: mc13xxx: Configure WDI reset
In-Reply-To: <540D5DEB.6020605@gmail.com>
References: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
 <540D5DEB.6020605@gmail.com>
Message-ID: <20140908092559.GB24081@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 08, 2014 at 09:42:35AM +0200, Philippe R?tornaz wrote:
> Hello
> 
> Le 08/09/2014 09:01, Markus Pargmann a ?crit :
> >Setup the PMIC to make a restart when a watchdog interrupt occures.
> >If this is not configured, the PMIC will shut down the power supply
> >without a restart.
> 
> 
> Well, this was used to poweroff the mx31moboard board.
> So we need to be able to configure the functionality.

So on mx31moboard the watchdog interrupt always leads to a poweroff instead of
a reset? Perhaps it would be better to switch back to poweroff on
watchdog interrupt right before the shutdown watchdog interrupt is
triggered.

Best regards

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/fbdf2974/attachment.sig>
