From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 Jan 2011 09:24:45 +0100
Subject: [PATCH 1/6] i2c-pxa: move i2c_pxa_remove to __devexit instead
	of just __exit
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110105082445.GL25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a bit of explanation would be nice here.  Something like:

	Subject: i2c-pxa: make sure the remove callback is called on unbind 

	When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
	callback was not called because it was discarded after boot or module
	load time.  Because of that the resources allocated in probe were not
	freed and so a rebind was impossible.

	Fix that by moving the remove callback to .devexit.text.

This way everyone can understand that a real bug is fixed here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
