From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 7 Apr 2017 15:23:17 +0200
Subject: [PATCH] clockevents/drivers/atlas7: set ->min_delta_ticks and
 ->max_delta_ticks
In-Reply-To: <20170330201022.8548-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
 <20170330201022.8548-1-nicstange@gmail.com>
Message-ID: <20170407132317.GI2078@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 10:10:21PM +0200, Nicolai Stange wrote:
> In preparation for making the clockevents core NTP correction aware,
> all clockevent device drivers must set ->min_delta_ticks and
> ->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
> clockevent device's rate is going to change dynamically and thus, the
> ratio of ns to ticks ceases to stay invariant.
> 
> Make the timer-atlas7 clockevent driver initialize these fields properly.
> 
> This patch alone doesn't introduce any change in functionality as the
> clockevents core still looks exclusively at the (untouched) ->min_delta_ns
> and ->max_delta_ns. As soon as this has changed, a followup patch will
> purge the initialization of ->min_delta_ns and ->max_delta_ns from this
> driver.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org> 

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
