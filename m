From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Jun 2016 17:11:40 +0200
Subject: [PATCH 0/2] use the CLK_IS_CRITICAL flag for critical clocks
In-Reply-To: <1467125137-25999-1-git-send-email-andi@etezian.org>
References: <1467125137-25999-1-git-send-email-andi@etezian.org>
Message-ID: <2143021.IyFNGTj97L@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

Am Dienstag, 28. Juni 2016, 17:45:35 schrieb andi.shyti at gmail.com:
> From: Andi Shyti <andi@etezian.org>
> this patchset is the first of a series and it aims to remove
> the handling of critical clock on the rockchip clock drivers.

I'm actually waiting on the second part of that to land.

The series introducing critical clocks also wanted to provide so called 
hand-off clocks (clocks being critical until a driver takes possession of 
them).

What are currently critical clocks in Rockchip drivers are essentially a mix 
of those two types, and I was somehow hoping that the handoff type also 
lands soonish so that we can limit ourselfs to one conversion step.


Heiko


> Patch 32b9b10961860860268961d9aad0c56a73018c37 has added a
> generic clock critical handling that can be used from the
> drivers.
> 
> Because I'm not expert in the clock framework, I want to check if
> this is fine and, if so, I will fire the other patches.
> 
> Thanks,
> Andi
> 
> Andi Shyti (2):
>   clk: clk-rk3*: set CLK_IS_CRITICAL flag to critical clocks
>   clk: rockchip: remove unused rockchip_clk_protect_critical function
> 
>  drivers/clk/rockchip/clk-rk3036.c |  18 ++-----
>  drivers/clk/rockchip/clk-rk3188.c |  25 +++-------
>  drivers/clk/rockchip/clk-rk3228.c |  17 ++-----
>  drivers/clk/rockchip/clk-rk3288.c |  21 +++-----
>  drivers/clk/rockchip/clk-rk3368.c |  22 ++-------
>  drivers/clk/rockchip/clk-rk3399.c | 101
> ++++++++++++++++---------------------- drivers/clk/rockchip/clk.c       
> |  14 ------
>  drivers/clk/rockchip/clk.h        |   1 -
>  8 files changed, 69 insertions(+), 150 deletions(-)
> 
> --
> 2.8.1
