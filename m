From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Sep 2015 06:18:03 +0200
Subject: [PATCH v2 1/4] clocksource: rockchip: Make the driver more
 compatible
In-Reply-To: <1443147298-12603-2-git-send-email-wxt@rock-chips.com>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
 <1443147298-12603-2-git-send-email-wxt@rock-chips.com>
Message-ID: <560A10FB.7040408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2015 04:14 AM, Caesar Wang wrote:
> Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
> There are some failure with build up on timer driver for rockchip.
>
> Says:
> /tmp/ccdAnNy5.s:47: Error: missing immediate expression at  operand 1 --
> `dsb`
> ...
>
> The problem was different semantics of dsb on btw arm32 and arm64,
> Here we can convert the dsb with insteading of dsb(sy).The "sy" param
> is the default which you are allow to omit, so on arm32 dsb()and dsb(sy)
> are the same.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
