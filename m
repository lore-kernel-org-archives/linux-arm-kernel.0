From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 05 Apr 2018 13:05:54 -0700
Subject: [PATCH] clk: ti: fix flag space conflict with clkctrl clocks
In-Reply-To: <0da17b8f-62af-1634-9dea-85445d28d587@ti.com>
References: <1522172824-14094-1-git-send-email-t-kristo@ti.com>
 <0da17b8f-62af-1634-9dea-85445d28d587@ti.com>
Message-ID: <152295875421.91052.344369730121423981@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2018-03-29 11:25:07)
> On 27/03/18 20:47, Tero Kristo wrote:
> > The introduction of support for CLK_SET_RATE_PARENT flag for clkctrl
> > clocks used a generic clock flag, which causes a conflict with the
> > rest of the clkctrl flags, namely the NO_IDLEST flag. This can cause
> > boot failures on certain platforms where this flag is introduced, by
> > omitting the wait for the clockctrl module to be fully enabled before
> > proceeding with rest of the code.
> > 
> > Fix this by moving all the clkctrl specific flags to their own bit-range.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Fixes: 49159a9dc3da ("clk: ti: add support for CLK_SET_RATE_PARENT flag")
> > Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> 
> Stephen, can you pick this up as a late fix?
> 

Sorry I was traveling for a week. I'll pick this up for this merge
window and then stable can get it.
