From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Nov 2015 15:27:39 +0100
Subject: [PATCH V2] clocksource/drivers/timer_sun5i: Replace code by
 clocksource_mmio_init
In-Reply-To: <20151112233129.GH32142@lukather>
References: <1447353613-18778-1-git-send-email-daniel.lezcano@linaro.org>
 <20151112233129.GH32142@lukather>
Message-ID: <5645F35B.7090503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 12:31 AM, Maxime Ripard wrote:
> On Thu, Nov 12, 2015 at 07:40:13PM +0100, Daniel Lezcano wrote:
>> The current code to initialize, register and read the clocksource is
>> already factored out in mmio.c via the clocksource_mmio_init function.
>>
>> The only difference is the readl vs readl_relaxed.
>>
>> Factor out the code with the clocksource_mmio_init function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks for the review. I applied the patch with a fix:

ret = clocksource_mmio_init(base + TIMER_CNTVAL_LO_REG(1),
			node->name,
			rate, 340, UINT_MAX,
			clocksource_mmio_readl_down);

Replaced UINT_MAX by '32'.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
