From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Aug 2016 11:11:31 +0200
Subject: [PATCH v3] clocksource: sun4i: Clear interrupts after stopping
 timer in probe function
In-Reply-To: <20160825062659.17433-1-wens@csie.org>
References: <20160825062659.17433-1-wens@csie.org>
Message-ID: <57BEB643.7030404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2016 08:26 AM, Chen-Yu Tsai wrote:
> The bootloader (U-boot) sometimes uses this timer for various delays.
> It uses it as a ongoing counter, and does comparisons on the current
> counter value. The timer counter is never stopped.
> 
> In some cases when the user interacts with the bootloader, or lets
> it idle for some time before loading Linux, the timer may expire,
> and an interrupt will be pending. This results in an unexpected
> interrupt when the timer interrupt is enabled by the kernel, at
> which point the event_handler isn't set yet. This results in a NULL
> pointer dereference exception, panic, and no way to reboot.
> 
> Clear any pending interrupts after we stop the timer in the probe
> function to avoid this.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Applied.

Thanks !

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
