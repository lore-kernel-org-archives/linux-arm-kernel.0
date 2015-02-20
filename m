From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 20 Feb 2015 16:34:11 +0100
Subject: [PATCH 7/7] serial: imx: add support for half duplex rs485
In-Reply-To: <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
 <20150219093752.GO19388@pengutronix.de>
 <CAFeThoC2+SGc1ZgQhbBx-pxxzpRJ-61n_fs8BZo8ChFcti3Vqw@mail.gmail.com>
Message-ID: <20150220153411.GP19388@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 10:45:47AM +0100, aur?lien bouin wrote:
> I hope this link will be ok :
> http://marc.info/?l=linux-kernel&m=142366865609389&q=raw
Good heavens, this patch is broken. It depends on user space to get the
reference counting for the gpio right if at all. It uses a reserved part
of the struct serial_rs485 while being driver specific. It ignores
gpio_request returning an error (well, it does a dev_err in this case,
but continues to use the gpio). It does change how frame error are
handled even if rs485 is off without mentioning in the changelog.

Are you aware what happens if a user issues the rs485 callback without
being aware that padding[0] has this meaning?

I'm sorry, I like my patch better.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
