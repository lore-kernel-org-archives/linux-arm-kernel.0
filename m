From: ricard.wanderlof@axis.com (Ricard Wanderlof)
Date: Tue, 7 Apr 2015 10:47:17 +0200
Subject: [alsa-devel] [PATCH 01/14] clk: update clk API documentation to
 clarify clk_round_rate()
In-Reply-To: <E1Ye58t-0001At-NZ@rmk-PC.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye58t-0001At-NZ@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1504071046120.967@lnxricardw1.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 3 Apr 2015, Russell King wrote:

> The idea is that rate = clk_round_rate(clk, r) is equivalent to:
> 
> 	clk_set_rate(clk, r);
> 	rate = clk_get_rate(clk);
> 
> except that clk_round_rate() does not change the hardware in any way.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  include/linux/clk.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 8381bbfbc308..d1ac9f3ab24b 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -288,6 +288,20 @@ void devm_clk_put(struct device *dev, struct clk *clk);
>   * @clk: clock source
>   * @rate: desired clock rate in Hz
>   *
> + * This answers the question "if I were to pass @rate to clk_set_rate(),
> + * what clock rate would I end up with?" without changing the hardware
> + * in any way.  In other words:
> + *
> + *   rate = clk_round_rate(clk, r);
> + *
> + * and:
> + *
> + *   clk_set_rate(clk, r);
> + *   rate = clk_get_rate(clk);
> + *
> + * are equivalent except the former does not modify the clock hardware
> + * in any way.
> + *
>   * Returns rounded clock rate in Hz, or negative errno.
>   */
>  long clk_round_rate(struct clk *clk, unsigned long rate);
> -- 
> 1.8.3.1

Very good. IMHO there should be much more documentation of this type 
in the kernel. 

/Ricard
-- 
Ricard Wolf Wanderl?f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
