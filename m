From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Sep 2014 13:48:47 -0700
Subject: [PATCH 02/11] clk: rockchip: fix rk3288 pll status register
 location
In-Reply-To: <1409958374-30937-3-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
 <1409958374-30937-3-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=XjzKA_dqMjysaP7pCy5OwAEO-fFgUnVQ5tFF8+w6XuyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 5, 2014 at 4:06 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> From: Jianqun <jay.xu@rock-chips.com>
>
> In RK3288, APLL lock status bit is in GRF_SOC_STATUS1,
> but in RK3188, is GRFSOC_STATUS0.
>
> Signed-off-by: Jianqun <jay.xu@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 038b1aa..4586578 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -20,7 +20,7 @@
>  #include "clk.h"
>
>  #define RK3288_GRF_SOC_CON(x)  (0x244 + x * 4)
> -#define RK3288_GRF_SOC_STATUS  0x280
> +#define RK3288_GRF_SOC_STATUS  0x284

I probably would have also given this a rename to GRF_SOC_STATUS1 to
make it a little clearer.  Mind doing that?

-Doug
