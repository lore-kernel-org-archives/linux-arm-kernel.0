From: dianders@chromium.org (Doug Anderson)
Date: Mon, 22 Sep 2014 10:51:02 -0700
Subject: [PATCH v3 8/8] clk: rockchip: switch to using the new cpuclk type
 for armclk
In-Reply-To: <1410991974-12235-9-git-send-email-heiko@sntech.de>
References: <1410991974-12235-1-git-send-email-heiko@sntech.de>
 <1410991974-12235-9-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=VC7NQrCq227OASQs+wogm2HZrF=PNz58MHXemp85kdkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Sep 17, 2014 at 3:12 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> +static struct rockchip_cpuclk_rate_table rk3288_cpuclk_rates[] = {
> +       RK3288_CPUCLK_RATE(1800000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE(1704000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE(1608000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE(1512000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE(1416000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE(1200000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE(1008000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 816000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 696000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 600000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 408000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 312000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 216000000, 2, 4, 2, 4, 4),
> +       RK3288_CPUCLK_RATE( 126000000, 2, 4, 2, 4, 4),
> +       { /* sentinel */ },
> +};

As Derek Basehore pointed out in another thread, this could be init
const.  ...but that could also happen in a followup patch.

...some of my review feedback on the "clk-cpu" patch might require
changes to this file but they would be minor, I think.  On rk3288 I've
stressed this series and things look good.  I've also generally
reviewed the code at a high level.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
