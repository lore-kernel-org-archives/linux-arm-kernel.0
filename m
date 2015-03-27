From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Mar 2015 11:41:34 +0100
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <139dc298c0914b3536445dddd37be286@agner.ch>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
 <139dc298c0914b3536445dddd37be286@agner.ch>
Message-ID: <20150327104134.GW32677@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 11:32:31AM +0100, Stefan Agner wrote:
> On 2015-03-24 16:26, Markus Pargmann wrote:
> > 0 is used in all pinfunction definitions when a config register is not
> > available, for example imx25-pinfunc.h. If a configuration value is used
> > for such a pinfunction the driver will always write it to the
> > configuration register if it is not -1. For a 0 configuration register
> > the configuration value is written to offset 0x0. This can lead to a
> > crashing/hanging system without any warning message.
> 
> 0 is a valid offset for Vybrid's mux register, however, since Vybrid set
> the SHARE_MUX_CONF_REG, intepreting a 0 in conf_reg as "not set"
> actually works.
> 
> What is a bit a bummer is that we now have different meanings of 0,
> depending on the field:
> - For the first field (mux), 0 is a valid offset
> - For the second field (config), 0 means not valid
> 
> However, I can't think of a easy solution which would solve this in a
> cleaner mannor... Maybe a comment in the function header how the 5 u32's
> are intepreted would appropriate?
That means that on Vybrid you need to write to offset 0 a config value?
Or not?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
