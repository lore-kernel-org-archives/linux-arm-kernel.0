From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Mar 2018 13:55:10 -0700
Subject: [PATCH] clk: ti: fix flag space conflict with clkctrl clocks
In-Reply-To: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
References: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
Message-ID: <20180327205510.GJ5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [180327 17:48]:
> The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
> clocks used a generic clock flag, which causes a conflict with the
> rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
> boot failures on certain platforms where this flag is introduced, by
> omitting the wait for the clockctrl module to be fully enabled before
> proceeding with rest of the code.
> 
> Fix this by moving all the clkctrl specific flags to their own bit-range.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>

I boot tested this on am437x-idk and bbb with multi_v7_defconfig, so:

Tested-by: Tony Lindgren <tony@atomide.com>
