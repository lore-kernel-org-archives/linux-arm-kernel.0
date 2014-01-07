From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 07 Jan 2014 16:22:46 +0100
Subject: [GIT PULL] Samsung Clock fixes for v3.13
In-Reply-To: <3900474.uee5rn6pUr@amdc1227>
References: <3900474.uee5rn6pUr@amdc1227>
Message-ID: <3440024.TplMaFaxpk@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 of January 2014 17:14:41 Tomasz Figa wrote:
> Hi Mike,
> 
> Please consider the following Samsung Clock fixes for v3.13.
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git tags/samsung-clk-fixes
> 
> for you to fetch changes up to 3fd68c99f3026f4fe3a1b7b6fb75e5638b2032fd:
> 
>   clk: exynos: File scope reg_save array should depend on PM_SLEEP (2013-12-30 18:01:09 +0100)
> 
> ----------------------------------------------------------------
> Samsung Clock fixes for v3.13-rc7
> 
> * Several patches fixing up incorrectly defined register addresses and
>   bitfield offsets that could lead to undefined operation when accessing
>   respective registers or bitfields.
> 
>  1) clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
> 
>  2a) clk: samsung: exynos5250: Fix ACP gate register offset
>  2b) clk: samsung: exynos5250: Add MDMA0 clocks
>  2c) ARM: dts: exynos5250: Fix MDMA0 clock number
> 
>  3) clk: samsung: exynos4: Correct SRC_MFC register
> 
>    All three issues have been present since Exynos5250 and Exynos4 clock
>    drivers were added by commits 6e3ad26816b72 ("clk: exynos5250:
>    register clocks using common clock framework") and e062b571777f5
>    ("clk: exynos4: register clocks using common clock framework")
>    respectively.
> 
> * Patch to fix automatic disabling of Exynos5250 sysreg clock that could
>   cause undefined operation of several peripherals, such as USB, I2C,
>   MIPI or display block.
> 
>  4) clk: samsung: exynos5250: Add CLK_IGNORE_UNUSED flag for the sysreg
>     clock
> 
>    Present since Exynos5250 clock drivers was added by commits
>    6e3ad26816b72 ("clk: exynos5250: register clocks using common clock
>    framework").
> 
> * Patch fixing compilation warning in clk-exynos-audss driver when
>   CONFIG_PM_SLEEP is disabled.
> 
>  5) clk: exynos: File scope reg_save array should depend on PM_SLEEP
> 
>    Present since the driver was added by commit 1241ef94ccc3 ("clk:
>    samsung: register audio subsystem clocks using common clock
>    framework").
> 
> ----------------------------------------------------------------
> Abhilash Kesavan (4):
>       clk: samsung: exynos5250: Fix ACP gate register offset
>       clk: samsung: exynos5250: Add MDMA0 clocks
>       ARM: dts: exynos5250: Fix MDMA0 clock number
>       clk: samsung: exynos5250: Add CLK_IGNORE_UNUSED flag for the sysreg clock
> 
> Andrew Bresticker (1):
>       clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
> 
> Krzysztof Kozlowski (1):
>       clk: exynos: File scope reg_save array should depend on PM_SLEEP
> 
> Seung-Woo Kim (1):
>       clk: samsung: exynos4: Correct SRC_MFC register
> 
>  .../devicetree/bindings/clock/exynos5250-clock.txt         |  2 ++
>  arch/arm/boot/dts/exynos5250.dtsi                          |  2 +-
>  drivers/clk/samsung/clk-exynos-audss.c                     | 10 +++++-----
>  drivers/clk/samsung/clk-exynos4.c                          |  2 +-
>  drivers/clk/samsung/clk-exynos5250.c                       | 14 +++++++++-----
>  5 files changed, 18 insertions(+), 12 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ping. We already missed 3.13-rc7, but those are only fixes that can't
introduce regressions so please pull this for 3.13-rc8.

Best regards,
Tomasz
