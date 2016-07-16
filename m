From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 16 Jul 2016 10:55:53 +0200
Subject: [PATCH] i2c: efm32: fix a failure path in efm32_i2c_probe()
In-Reply-To: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
References: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20160716085553.GI6040@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 02:36:38AM +0300, Alexey Khoroshilov wrote:
> There is the only failure path in efm32_i2c_probe(),
> where clk_disable_unprepare() is missed.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

oops, this is wrong since the beginning.

Fixes: 1b5b23718b84 ("i2c: efm32: new bus driver")
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
