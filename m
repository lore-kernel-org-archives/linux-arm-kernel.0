From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Jun 2012 19:52:34 +0200
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120627175234.GF18096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, May 25, 2012 at 04:22:41PM +0200, Sascha Hauer wrote:
> The following commit changes the function used to copy from/to
> the hardware buffer to memcpy_[from|to]io. This does not work
> since the hardware cannot handle the byte accesses used by these
> functions. Instead of reverting this patch introduce 32bit
> correspondents of these functions.
> 
> commit 5775ba36ea9c760c2d7e697dac04f2f7fc95aa62
> Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Date:   Tue Apr 24 10:05:22 2012 +0200
> 
>     mtd: mxc_nand: fix several sparse warnings about incorrect address space
> 
>     Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>     Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I don't know about the sparse problems this introduces, but without this
patch the mxc-nand driver is broken, so it should really go in before
3.5.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
