From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 6 Nov 2015 10:07:59 +0100
Subject: [PATCH v3] clocksource/drivers/dw_apb_timer_of: Implement ARM
 delay timer
In-Reply-To: <1446690726-2024-1-git-send-email-jszhang@marvell.com>
References: <1446690726-2024-1-git-send-email-jszhang@marvell.com>
Message-ID: <563C6DEF.2040905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 03:32 AM, Jisheng Zhang wrote:
> Implement an ARM delay timer to be used for udelay(). This allows us to
> skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
> platforms. And after this patch, udelay() will be unaffected by CPU
> frequency changes.
>
> Note: Although in case there are several possible delay timers, we may
> not select the "best" delay timer. Take one Marvell Berlin platform for
> example: we have arch timer and dw-apb timer. The arch timer freq is
> 25MHZ while the dw-apb timer freq is 100MHZ, current selection would
> choose the dw-apb timer. But the dw apb timer is on the APB bus while
> arch timer sits in CPU, the cost of accessing the apb timer is higher
> than the arch timer. We could introduce "rating" concept to delay
> timer, but this approach "brings a lot of complexity and workarounds
> in the code for a small benefit" as pointed out by Daniel.
>
> Later, Arnd pointed out "However, we could argue that this actually
> doesn't matter at all, because the entire point of the ndelay()/
> udelay()/mdelay() functions is to waste CPU cycles doing not much at
> all, so we can just as well waste them reading the timer register
> than spinning on the CPU reading the arch timer more often.", so we
> just simply register the dw apb base delay timer.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---

Applied, thanks!

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
