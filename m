From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 12 Apr 2012 11:51:13 +0530
Subject: [PATCH 09/13] clk: Make clk_get_rate() return 0 on error
In-Reply-To: <1334192572-12499-10-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-10-git-send-email-mturquette@linaro.org>
Message-ID: <4F867459.20806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2012 6:32 AM, Mike Turquette wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Most users of clk_get_rate() actually assume a non zero
> return value as a valid rate returned. Returing -EINVAL
> might confuse such users, so make it instead return zero
> on error.
> 
> Besides the return value of clk_get_rate seems to be
> 'unsigned long'.
> 
> Signed-off-by: Rajendra nayak <rnayak@ti.com>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Cc: Arnd Bergman <arnd.bergmann@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Richard Zhao <richard.zhao@linaro.org>
> Cc: Saravana Kannan <skannan@codeaurora.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/clk/clk.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9924aec..a24b121 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -285,7 +285,7 @@ unsigned long __clk_get_rate(struct clk *clk)
>  	unsigned long ret;
>  
>  	if (!clk) {
> -		ret = -EINVAL;
> +		ret = 0;
>  		goto out;
>  	}
>  
> @@ -295,7 +295,7 @@ unsigned long __clk_get_rate(struct clk *clk)
>  		goto out;
>  
>  	if (!clk->parent)
> -		ret = -ENODEV;
> +		ret = 0;
>  
>  out:
>  	return ret;
> @@ -560,7 +560,7 @@ EXPORT_SYMBOL_GPL(clk_enable);
>   * @clk: the clk whose rate is being returned
>   *
>   * Simply returns the cached rate of the clk.  Does not query the hardware.  If
> - * clk is NULL then returns -EINVAL.
> + * clk is NULL then returns 0.
>   */
>  unsigned long clk_get_rate(struct clk *clk)
>  {

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
