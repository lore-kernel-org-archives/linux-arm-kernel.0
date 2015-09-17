From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Sep 2015 11:11:49 +0200
Subject: [PATCH 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <1442476272-31723-2-git-send-email-wxt@rock-chips.com>
References: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
 <1442476272-31723-2-git-send-email-wxt@rock-chips.com>
Message-ID: <55FA83D5.9010504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Caesar,


On 09/17/2015 09:51 AM, Caesar Wang wrote:
> Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
> There are some failure with build up on timer driver for rockchip.
>
> logs:
> ...
> drivers/clocksource/rockchip_timer.c:156:13: error: 'NO_IRQ' undeclared

I think the NO_IRQ definition is missing for ARM64.

> /tmp/ccdAnNy5.s:47: Error: missing immediate expression at  operand 1 --
> `dsb`
> ...
>
> The problem was different semantics of dsb on btw arm32 and arm64,
> Here we can convert the dsb with insteading of dsb(sy).

What happens to ARM32 then ?

> Meanwhile, I change a bit to make the code more readability for driver
> when I check the code style.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
