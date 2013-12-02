From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Dec 2013 12:57:21 +0100
Subject: [REPOST PATCH] ARM: sunxi: stop timer from ticking before enabling
 interrupts
In-Reply-To: <1385976575-28011-1-git-send-email-marc.zyngier@arm.com>
References: <1385976575-28011-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <529C75A1.8020009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 10:29 AM, Marc Zyngier wrote:
> The sun4i timer can still be ticking when we enable the interrupt.
> If another timer is actually used (A7 architected timer, for example),
> odds are that the interrupt will eventually fire with the event_handler
> pointer being NULL.
>
> The obvious fix it to stop the timer before registering the interrupt.
>
> Observed and tested on sun7i (cubietruck).
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Applied to my tree as 3.13 fixes.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
