From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 30 Aug 2013 15:51:20 +0200
Subject: [PATCH v2 00/16] Exynos clock clean-up for 3.12
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1920907.Hu7ncHu6EC@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Monday 26 of August 2013 19:08:55 Tomasz Figa wrote:
> This series fixes various functional and non-functional (e.g. stylistic)
> issues in Common Clock Framework drivers for Samsung Exynos SoCs. See
> particular patches for more detailed descriptions.
> 
> Changes since v1:
> [http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg21665.h
> tml] - Addressed comments from Yadwinder Singh Brar:
>    - added missing __initdata keywords,
>    - various typoes fixed,
>    - other minor stylistic improvements.
> 
> Tomasz Figa (16):
>   pwm: samsung: Update DT bindings documentation to cover clocks
>   ARM: dts: exynos4: Specify PWM clocks in PWM node
>   clocksource: samsung_pwm_timer: Get clock from device tree
>   clk: samsung: exynos4: Use separate aliases for cpufreq related clocks
>   clk: samsung: Modify _get_rate() helper to use __clk_lookup()
>   clk: samsung: exynos4: Remove unused static clkdev aliases
>   clk: samsung: exynos4: Remove checks for DT node
>   clk: samsung: exynos4: Rename exynos4_plls to exynos4x12_plls
>   clk: samsung: pll: Use new registration method for PLL45xx
>   clk: samsung: pll: Add support for rate configuration of PLL45xx
>   clk: samsung: pll: Use new registration method for PLL46xx
>   clk: samsung: pll: Add support for rate configuration of PLL46xx
>   clk: samsung: exynos4: Reorder registration of mout_vpllsrc
>   clk: samsung: exynos4: Register PLL rate tables for Exynos4210
>   clk: samsung: exynos4: Register PLL rate tables for Exynos4x12
>   clk: samsung: exynos5250: Simplify registration of PLL rate tables
> 
>  .../devicetree/bindings/pwm/pwm-samsung.txt        |  12 +
>  arch/arm/boot/dts/exynos4.dtsi                     |   2 +
>  drivers/clk/samsung/clk-exynos4.c                  | 539
> ++++++++++++--------- drivers/clk/samsung/clk-exynos5250.c              
> |  12 +-
>  drivers/clk/samsung/clk-exynos5440.c               |   2 +-
>  drivers/clk/samsung/clk-pll.c                      | 285 ++++++++---
>  drivers/clk/samsung/clk-pll.h                      |  59 ++-
>  drivers/clk/samsung/clk.c                          |  10 +-
>  drivers/clocksource/samsung_pwm_timer.c            |  12 +-
>  9 files changed, 602 insertions(+), 331 deletions(-)

Any chance to still have this merged for 3.12? AFAIK this should apply 
cleanly on your clk-next without any dependencies from other trees.

Best regards,
Tomasz
