From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Jan 2016 10:03:43 +0100
Subject: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
 <20160115075356.GI24441@pengutronix.de>
 <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
Message-ID: <20160115090343.GK24441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Li,

On Fri, Jan 15, 2016 at 04:46:06PM +0800, Li Yang wrote:
> On Fri, Jan 15, 2016 at 3:53 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
> >> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
> >
> > I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and then use
> >
> >         if (!i2c_imx->pinctrl)
> >
> > here. (Or maybe make i2c_imx_init_recovery_info aware of this situation
> > to keep the caller simple?)
> 
> Setting not used pointer to NULL might be a good coding practice
> generally.  But in this case neither the driver nor gpio framework
> checks if the pinctrl is NULL before accessing it.  We still need the
> driver to make sure pinctrl is not used in this situation.  The
> benefit of the proposed change seems to be pretty limited.  :)

At least it gets rid of IS_ERR_OR_NULL which is used wrongly more often
than not.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
