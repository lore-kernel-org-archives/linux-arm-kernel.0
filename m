From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 5 Jan 2011 09:19:15 +0000
Subject: [PATCH 1/6] i2c-pxa: move i2c_pxa_remove to __devexit instead
	of just __exit
In-Reply-To: <20110105082445.GL25121@pengutronix.de>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
	<20110105082445.GL25121@pengutronix.de>
Message-ID: <20110105091915.GV27131@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 09:24:45AM +0100, Uwe Kleine-K?nig wrote:
> a bit of explanation would be nice here.  Something like:
> 
> 	Subject: i2c-pxa: make sure the remove callback is called on unbind 
> 
> 	When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
> 	callback was not called because it was discarded after boot or module
> 	load time.  Because of that the resources allocated in probe were not
> 	freed and so a rebind was impossible.
> 
> 	Fix that by moving the remove callback to .devexit.text.
> 
> This way everyone can understand that a real bug is fixed here.

agreed, please re-submit

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
