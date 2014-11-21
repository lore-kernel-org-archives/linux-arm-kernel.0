From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 21 Nov 2014 10:56:39 +0800
Subject: [PATCH v2 0/4] clk: rockchip: allow adjusting pll rates on init
In-Reply-To: <1416512333-15438-1-git-send-email-heiko@sntech.de>
References: <1416512333-15438-1-git-send-email-heiko@sntech.de>
Message-ID: <546EA9E7.6090104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 11/21/2014 03:38 AM, Heiko Stuebner wrote:
> It was found that some firmware versions initialized the pll rates using
> suboptimal parameters to achieve frequencies the actual rate table contained
> better parameters for.
>
> Therefore this series first adds the possibility to create pll-specific flags
> and then adds a flag to adjust the pll rate on init to the parameters from
> the rate table.
>
> changes since v1:
> - move population of pll_mux before registering the core pll clock
>    null pointer exception in the _set_rate callback when called from init
>
> Heiko Stuebner (4):
>    clk: rockchip: add ability to specify pll-specific flags
>    clk: rockchip: setup pll_mux data earlier
>    clk: rockchip: add optional sync to pll rate parameters
>    clk: rockchip: add ROCKCHIP_PLL_SYNC_RATE flag to some plls
>
>   drivers/clk/rockchip/clk-pll.c    | 81 +++++++++++++++++++++++++++++++--------
>   drivers/clk/rockchip/clk-rk3188.c |  8 ++--
>   drivers/clk/rockchip/clk-rk3288.c | 10 ++---
>   drivers/clk/rockchip/clk.c        |  3 +-
>   drivers/clk/rockchip/clk.h        | 13 ++++++-
>   5 files changed, 88 insertions(+), 27 deletions(-)
>
The PLLs may have different usage, so add the pll-specific flag make sense.

I have test this patch set on both rk3288 evb and rk3288 pinky.

For this series:
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Kever Yang <kever.yang@rock-chips.com>
