From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Mar 2015 09:35:18 +0100
Subject: [PATCH 1/3] clk: divider: fix calculation of maximal parent rate
 for a given divider
In-Reply-To: <1424515225-6929-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424515225-6929-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150305083518.GR7865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike, hello Stephen,

On Sat, Feb 21, 2015 at 11:40:23AM +0100, Uwe Kleine-K?nig wrote:
> The rate provided at the output of a clk-divider is calculated as:
> 
> 	DIV_ROUND_UP(parent_rate, div)
> 
> since commit b11d282dbea2 (clk: divider: fix rate calculation for
> fractional rates). So to yield a rate not bigger than r parent_rate
> must be <= r * div.
> 
> The effect of choosing a parent rate that is too big as was done before
> this patch results in wrongly ruling out good dividers.
> 
> Note that this is not a complete fix as __clk_round_rate might return a
> value >= its 2nd parameter. Also for dividers with
> CLK_DIVIDER_ROUND_CLOSEST set the calculation is not accurate. But this
> fixes the test case by Sascha Hauer that uses a chain of three dividers
> under a fixed clock.
> 
> Fixes: b11d282dbea2 (clk: divider: fix rate calculation for fractional rates)
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Gentle ping.

IMHO this is patch should go into 4.0.

Feedback for patches 2 and 3 (or the alternative to rip off specialised
round-closest) would be very welcome, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
