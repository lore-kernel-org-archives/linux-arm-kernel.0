From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 29 Aug 2013 14:43:30 +0200
Subject: [PATCH v2 00/16] Exynos clock clean-up for 3.12
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <521F41F2.4000406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/26/2013 07:08 PM, Tomasz Figa wrote:
> This series fixes various functional and non-functional (e.g. stylistic)
> issues in Common Clock Framework drivers for Samsung Exynos SoCs. See
> particular patches for more detailed descriptions.
> 
> Changes since v1:
> [http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg21665.html]
>  - Addressed comments from Yadwinder Singh Brar:
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

This series look good to me,

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I have also tested it on top of the media tree (based on v3.11-rc2),
with some additional patches to enable the display and camera on
exynos4412 Trats 2 board and with most of patches from clk-next.
It seems this series doesn't cause any issues.

--
Regards,
Sylwester
