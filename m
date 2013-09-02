From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Sep 2013 10:54:17 +0200
Subject: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel
 parameter
In-Reply-To: <4002844.4ZqqJexTv4@amdc1032>
References: <4002844.4ZqqJexTv4@amdc1032>
Message-ID: <52245239.4000903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2013 12:21 PM, Bartlomiej Zolnierkiewicz wrote:
> Add "cpuidle-exynos.max_states=" parameter to allow user to specify
> the maximum of allowed CPU idle states for ARM EXYNOS cpuidle driver.
> 
> This change is needed because C1 state (AFTR mode) is often not able
> to work properly due to incompatibility with some bootloader versions.
> 
> Usage examples:
> 
> "cpuidle-exynos.max_states=1" disables C1 state (AFTR mode).
> 
> "cpuidle-exynos.max_states=0" disables the driver completely.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>

There is a max_cstate option for acpi and intel idle. There is also the
cpuidle.off=1 option. As the semantic is the same, I think adding a
common cpuidle option usable for all the drivers is better.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
