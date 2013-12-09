From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Dec 2013 11:00:51 +0100
Subject: panda board es failed on cpuidle
In-Reply-To: <52A5936E.5050409@linaro.org>
References: <52A5936E.5050409@linaro.org>
Message-ID: <52A594D3.4060809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 10:54 AM, Alex Shi wrote:
> my panda board ES failed to boot up when I use omap2plus_defconfig + CPU_IDLE.
> Is it a known issue or I missed sth in kernel?
>
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y
>
>
> kernel hang after the following output.
>
>      2.276641] omap_hsmmc 4809c000.mmc: pins are not configured from the driver
> [    2.325531] pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x38 (0x38)
> [    2.333648] pinctrl-single 4a31e040.pinmux: could not add functions for pinmux_wl12xx_pins 56x
> [    2.343231] omap-dma-engine 4a056000.dma-controller: allocating channel for 60
> [    2.351043] omap-dma-engine 4a056000.dma-controller: allocating channel for 59
> [    2.358917] 480d5000.mmc supply vmmc_aux not found, using dummy regulator
> [    2.383331] hw-breakpoint: Failed to enable monitor mode on CPU 0.
> [    2.390411] hw-breakpoint: CPU 0 failed to disable vector catch

Yes, I saw an email talking about a hang with cpuidle + omap4.

The thread is http://www.spinics.net/lists/linux-omap/msg99899.html

and the patch bringing the fix is 
https://patchwork.kernel.org/patch/3084521/

Hope that helps.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
