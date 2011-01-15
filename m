From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 15 Jan 2011 16:03:31 +0100
Subject: Locking in the clk API
In-Reply-To: <20110115145358.GC15996@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
	<20110112090301.GS11039@n2100.arm.linux.org.uk>
	<4D31A8F1.4080301@weinigel.se>
	<20110115145358.GC15996@n2100.arm.linux.org.uk>
Message-ID: <20110115150331.GB6917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Jan 15, 2011 at 02:53:58PM +0000, Russell King - ARM Linux wrote:
> We've been around returning EAGAIN, WARN_ONs, BUG_ONs, having clk_enable()
> vs clk_enable_atomic(), clk_enable_cansleep() vs clk_enable(), etc.
> 
> There's been a lot of talk on this issue for ages with no real progress
> that I'm just going to repeat: let's unify those implementations which
> use a spinlock for their clks into one consolidated solution, and
> a separate consolidated solution for those which use a mutex.
> 
> This will at least allow us to have _some_ consolidation of the existing
> implementations - and it doesn't add anything to the problem at hand.
> It might actually help identify what can be done at code level to resolve
> this issue.
Great, so how should we do it?  Take Jeremy's patch and make the
differenciation between sleeping and atomic implementation a Kconfig
variable?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
