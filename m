From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 14 Jan 2016 10:25:40 +0100
Subject: [PATCH] clocksource: ftm: select CLKSRC_MMIO
In-Reply-To: <11970328.RVc8t0Mk1C@wuerfel>
References: <11970328.RVc8t0Mk1C@wuerfel>
Message-ID: <56976994.2060205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 12:02 AM, Arnd Bergmann wrote:
> The ftm clocksource driver does not build if CLKSRC_MMIO is disabled:
>
> drivers/built-in.o: In function `ftm_timer_init':
> (init.text+0xd324): undefined reference to `clocksource_mmio_init'
> (init.text+0xd484): undefined reference to `clocksource_mmio_readl_up'
>
> This adds the same 'select' statement that the other similar drivers
> use. Prior to allowing this driver to be enabled with COMPILE_TEST,
> it was apparently unused. I'm not entirely sure who is using this
> hardware, but it certainly can't hurt to ensure it builds cleanly.

Hi Arnd,

Thanks for the fix. It is already in Thomas's tree [1].

It has been merged in tip/timers/urgent. You will have to wait a bit 
this branch to be merged with tip/timers/core.

   -- Daniel

[1] 
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/urgent&id=03724ac3d48f8f0e3caf1d30fa134f8fd96c94e2



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
