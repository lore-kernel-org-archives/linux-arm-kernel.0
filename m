From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 01 Feb 2015 15:26:36 -0800
Subject: Clock Regression in next-20150130 caused by cb75a8fcd14e
In-Reply-To: <20150131010443.GE16250@atomide.com>
References: <20150131010443.GE16250@atomide.com>
Message-ID: <20150201232636.421.58980@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Lindgren (2015-01-30 17:04:44)
> Hi all,
> 
> Looks like commit cb75a8fcd14e ("clk: Add rate constraints to clocks")
> causes a regression on at least omaps where the serial console either
> does not show anything, or just prints garbage.
> 
> Reverting cb75a8fcd14e makes things work again on next-20150130.
> 
> Any ideas?

Stephen posted a patch[0] to fix this. I've squashed that into Tomeu's
commit that you reference above and my Panda board is booting fine once
again.

[0] http://lkml.kernel.org/r/<20150131013158.GA4323@codeaurora.org>

Please let me know if any other issues pop up. There are new WARNs for
OMAP3+ boards introduced by a different patch from Tomeu, but this is
really because the OMAP DPLL and FAPLL code are dereferencing struct clk
pointers when they should not be and is a separate issue from the
constraints patch (with a separate email thread).

Regards,
Mike

> 
> Regards,
> 
> Tony
