From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 25 Jul 2013 14:34:14 +0200
Subject: [PATCH v5 4/5] clk: add CLK_SET_RATE_NO_REPARENT flag
In-Reply-To: <1371139562-305-5-git-send-email-james.hogan@imgtec.com>
References: <1371139562-305-1-git-send-email-james.hogan@imgtec.com>
 <1371139562-305-5-git-send-email-james.hogan@imgtec.com>
Message-ID: <51F11B46.7010900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 06/13/2013 06:06 PM, James Hogan wrote:
> Add a CLK_SET_RATE_NO_REPARENT clock flag, which will prevent muxes
> being reparented during clk_set_rate.
> 
> To avoid breaking existing platforms, all callers of clk_register_mux()
> are adjusted to pass the new flag. Platform maintainers are encouraged
> to remove the flag if they wish to allow mux reparenting on set_rate.
[..]
> Changes in v3:
> 
> * rename/invert CLK_SET_RATE_REMUX to CLK_SET_RATE_NO_REPARENT and move
>   to this new patch.
> * patch 3: add CLK_SET_RATE_NO_REPARENT flag to all callers of
>   clk_register_mux. If you don't mind your clocks being reparented in
>   response to set_rate please let me know and I'll drop the relevant
>   portion of the patch.

Why is this better to change current behaviour of the clock core
and modify all drivers instead of having, e.g. CLK_SET_RATE_REPARENT
set in drivers of hardware that supports clock re-parenting while
setting clock rate ?

Is there intention to just have the automatic clock re-parenting
as a default feature in the common clock API ?
My apologies if this has already been answered, I haven't been
following this thread.

Thanks,
Sylwester

>  arch/arm/mach-imx/clk.h              |   5 +-
>  drivers/clk/mmp/clk-mmp2.c           |  39 +++++---
>  drivers/clk/mmp/clk-pxa168.c         |  40 +++++---
>  drivers/clk/mmp/clk-pxa910.c         |  31 +++---
>  drivers/clk/mxs/clk.h                |   4 +-
>  drivers/clk/samsung/clk.h            |   2 +-
>  drivers/clk/spear/spear1310_clock.c  | 179 ++++++++++++++++++-----------------
>  drivers/clk/spear/spear1340_clock.c  |  97 ++++++++++---------
>  drivers/clk/spear/spear3xx_clock.c   |  57 +++++++----
>  drivers/clk/spear/spear6xx_clock.c   |  35 +++----
>  drivers/clk/sunxi/clk-sunxi.c        |   3 +-
>  drivers/clk/tegra/clk-tegra114.c     |  36 ++++---
>  drivers/clk/tegra/clk-tegra20.c      |   6 +-
>  drivers/clk/tegra/clk-tegra30.c      |  33 ++++---
>  drivers/clk/versatile/clk-vexpress.c |   4 +-
>  include/linux/clk-provider.h         |   1 +
>  16 files changed, 334 insertions(+), 238 deletions(-)

-- 
Sylwester Nawrocki
Samsung R&D Institute Poland
