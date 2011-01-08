From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 8 Jan 2011 17:18:28 +0100
Subject: [PATCH] i2c-pxa: fix unbinding/rebinding of the device
In-Reply-To: <1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
References: <20110106124028.GX25121@pengutronix.de>
	<1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110108161828.GC8237@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 08, 2011 at 07:06:44PM +0300, Dmitry Eremin-Solenikov wrote:
> When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
> callback was not called because it was discarded when linking the
> kernel.  Because of that the resources allocated in probe were not
> freed and so a clean unbind/rebind was impossible.
> 
> Fix that by moving the remove callback to .devexit.text.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
