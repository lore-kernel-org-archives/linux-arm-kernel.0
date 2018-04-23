From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Mon, 23 Apr 2018 15:42:28 +0000
Subject: [PATCH] ARM: tegra: fix ulpi regression on tegra20
In-Reply-To: <6600596.BijQW1iq1K@ax5200p>
References: <20180219151252.29289-1-marcel@ziswiler.com>
 <6600596.BijQW1iq1K@ax5200p>
Message-ID: <1524498146.4493.35.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

On Fri, 2018-04-20 at 10:52 +0200, Marc Dietrich wrote:
> 
> ...
> I booted 4.17-rc1 (which includes this fix) on an AC100 (T20 paz00
> board) and 
> the error above is still there. Surprisingly the error vanishes when
> I revert 
> your patch. So this patch actually *causes* the problem above on my
> board.

That's really strange.

I believe I do have one of them paz00 boards laying around somewhere as
well. Just need to dig it out again and will give it a try. Looking at
their schematics at least reveals the exact same circuit as found on
all other T20 based boards using DAP_MCLK2 as REFCLK to the USB3315C
which BTW is 24 MHz and not 26 MHz as CDEV2 claims!

> Could it be, that we need all four clocks? Dimitry mentioned on IRC
> that it 
> could also be a problem in the clock init table. I don't have the
> technical 
> background myself to fix it, but I still wonder what could be so
> different 
> between TrimSlice and AC100.

I am wondering the same. However I still suspect that something is
completely wrong in that area as that CDEV2 clock is completely bogus.
It really does not exist!

> Marc

Cheers

Marcel
