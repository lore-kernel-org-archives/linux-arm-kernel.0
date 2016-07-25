From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 25 Jul 2016 15:34:10 -0700
Subject: [PATCH v3] PM / OPP: optimize dev_pm_opp_set_rate() performance
 a bit
In-Reply-To: <1469427076-2078-1-git-send-email-jszhang@marvell.com>
References: <1469427076-2078-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160725223410.GF25667@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-07-16, 14:11, Jisheng Zhang wrote:
> In dev_pm_opp_set_rate(), _find_opp_table() is called 4 times: once by
> _get_opp_clk(), once by dev_pm_opp_set_rate() itself, and twice by
> dev_pm_opp_find_freq_ceil(). If there are several opp_tables in the
> system, three times of opp table finding is a big waste. This patch
> reduced the call of _find_opp_table() to twice.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Since v2:
>  - fix gcc warnings
> 
> Since v1:
>  - avoid opp_table pointer usage after the rcu_read_unlock() as pointed
>    out by Viresh, thus we can only reduced the call of _find_opp_table
>    to twice.
> 
>  drivers/base/power/opp/core.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
