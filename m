From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Nov 2014 14:32:45 -0800
Subject: [GIT PULL] clk: rockchip: first batch for 3.19
In-Reply-To: <2664317.ZRy0zABv1Y@diego>
References: <2664317.ZRy0zABv1Y@diego>
Message-ID: <20141118223245.25314.5165@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-11-17 16:50:25)
> Hi Mike
> 
> here is a first batch of rockchip related clock changes for 3.19 .
> Apart from various small fixes we also move away from marking
> all clocks as INGORE_UNUSED to letting the ccf handle disabling
> most of the unused clocks.
> 
> So if this looks good, please pull
> 
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-clk1
> 
> for you to fetch changes up to 29e94468516cdf191ec839ee39f79e011817276d:
> 
>   clk: rockchip: fix clock select order for rk3288 usbphy480m_src (2014-11-16 00:40:19 +0100)

Pulled!

Thanks,
Mike

> 
> ----------------------------------------------------------------
> - fixes for clock ordering/rate issues
> - do not keep all clocks enabled anymore
> - allow special pll rates for special cases
> 
> ----------------------------------------------------------------
> Chris Zhong (1):
>       clk: rockchip: rk3288: add suspend and resume
> 
> Dmitry Torokhov (1):
>       clk: rockchip: ensure HCLK_VIO2_H2P and PCLK_VIO2_H2P stay enabled
> 
> Doug Anderson (1):
>       clk: rockchip: Add CLK_SET_RATE_PARENT to aclk_cpu_pre
> 
> Heiko St?bner (1):
>       clk: rockchip: fix rk3188 hsadc_frac definition
> 
> Jianqun (1):
>       clk: rockchip: rk3288: removing the CLK_SET_RATE_PARENT from i2s_clkout
> 
> Kever Yang (6):
>       clk: rockchip: add 400MHz and 500MHz for rk3288 clock rate
>       clk: rockchip: add npll to source of sclk_gpu
>       clk: rockchip: change PLL setting for better clock jitter
>       clk: rockchip: disable unused clocks
>       clk: rockchip: fix rk3288 clk_usbphy480m_gate bit location in register
>       clk: rockchip: fix clock select order for rk3288 usbphy480m_src
> 
> Sonny Rao (1):
>       clk: rockchip: fix parent for spdif_8ch_frac on rk3288
> 
>  drivers/clk/rockchip/clk-rk3188.c |  42 ++++----
>  drivers/clk/rockchip/clk-rk3288.c | 216 ++++++++++++++++++++++++--------------
>  drivers/clk/rockchip/clk.c        |   9 --
>  drivers/clk/rockchip/clk.h        |   9 ++
>  4 files changed, 169 insertions(+), 107 deletions(-)
> 
