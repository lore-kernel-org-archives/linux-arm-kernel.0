From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 Dec 2015 21:42:05 +0100
Subject: [PATCH v4 0/2] clocksource/drivers/dw_apb_timer: improve
 performance a bit
In-Reply-To: <1448467313-5626-1-git-send-email-jszhang@marvell.com>
References: <1448467313-5626-1-git-send-email-jszhang@marvell.com>
Message-ID: <56707B1D.10807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 05:01 PM, Jisheng Zhang wrote:
> These two patches try to improve the dw_apb_timer clocksource/clockevent
> performance.
>
> These patches depend on the apbt_readl return value fix patch:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/388250.html
>
> since v3:
>   - fix commit msg: we measured 4096 rounds of function call. So add this
>     information into commit msg to avoid confusion.
>
> since v2:
>   - only use relaxed version in critical path
>   - inline apbt_readl/apbt_writel
>   - add some performance numbers
>
> since v1:
>   - correct the wrong sentence in commit msg about writel performance on
>     CA9 with outer L2 cache. Thank Arnd for pointing out this in another
>     thread.
>
>
> Jisheng Zhang (2):
>    clocksource/drivers/dw_apb_timer: Inline apbt_readl and apbt_writel
>    clocksource/drivers/dw_apb_timer: Use {readl|writel}_relaxed in
>      critical path
>
>   drivers/clocksource/dw_apb_timer.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)

Applied.

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
