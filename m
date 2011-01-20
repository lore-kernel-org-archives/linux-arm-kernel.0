From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 Jan 2011 17:02:55 +0000
Subject: Locking in the clk API
In-Reply-To: <AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111091607.GI12552@n2100.arm.linux.org.uk>	<201101111744.59712.jeremy.kerr@canonical.com>	<20110111103929.GN24920@pengutronix.de>
	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
Message-ID: <4D386ABF.9060908@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/11 11:15, Richard Zhao wrote:
> 2011/1/11 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

[snip]

> A well running board will not enable/disable PLLs frequently. It don't
> make sense. PLLs are normally disabled on request to enter low power
> mode, rather not because all their child clocks are disabled.   So we
> don't have to consider the time here.

I'd rather see that if all child clocks are disabled the PLL is
powered down then. It means PLLs _could_ be left running even
when power-down mode is selected because the system still thinks
that a peripheral is using them.

If you want to make it so that each low-power mode has to work
out what PLLs need to be disabled and then re-enabled makes me
want to be sick. Hiding this stuff behind specific implementations
is a recipe for disaster.
