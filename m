From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 7 Jun 2013 10:24:57 +0200
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: change wait method for PLL
 lock
In-Reply-To: <1370593146-14025-1-git-send-email-peter.chen@freescale.com>
References: <1370593146-14025-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130607082457.GF12361@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 04:19:06PM +0800, Peter Chen wrote:
> For some unknown reasons, the jiffies will be updated more
> than one tick at every short time. Eg, at this code:
> After timeout = jiffies + msecs_to_jiffies(10),
> the interrupt occurs, and the softirq updates jiffies (eg,  + 2 jiffies),
> then return back from interrupt, the time between above operations
> are tiny, the PLL is still not locked, but the timeout condition is satisfied.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
Does this mean my patch doesn't solve the issue for you?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
