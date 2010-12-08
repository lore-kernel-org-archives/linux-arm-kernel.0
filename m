From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 10:31:05 +0100
Subject: [PATCH v3 06/15] ARM: mxs: Add timer support
In-Reply-To: <19711.16943.870381.557719@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-5-git-send-email-shawn.guo@freescale.com>
	<19711.16943.870381.557719@ipc1.ka-ro>
Message-ID: <20101208093105.GH18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Wed, Dec 08, 2010 at 09:30:39AM +0100, Lothar Wa?mann wrote:
> > +	switch (mode) {
> > +	case CLOCK_EVT_MODE_PERIODIC:
> > +		printk(KERN_ERR "mxs_set_mode: Periodic mode is not "
> > +				"supported for MXS-based\n");
> >
> Please do not line wrap message strings. Also, if you want the
> function name to appear in the message, use __func__ or __FUNCTION__.
> That way the name is always correct even if the function is renamed or
> the printk() statement is copied to a different function.
__FUNCTION__ isn't considered good, so please use __func__.
(__FUNCTION__ is a gcc extension, __func__ is c99 (I think)).
checkpatch warns about __FUNCTION__, too.

Shawn, you can also consider using pr_err.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
