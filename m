From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 10:29:52 +0200
Subject: [PATCH v3 1/3] clk: rockchip: add dt-binding header for rk3128
In-Reply-To: <1495501865-18512-2-git-send-email-zhangqing@rock-chips.com>
References: <1495501865-18512-1-git-send-email-zhangqing@rock-chips.com>
 <1495501865-18512-2-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1725571.3NA4bbO7jm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Dienstag, 23. Mai 2017, 09:11:03 CEST schrieb Elaine Zhang:
> Add the dt-bindings header for the rk3128,
> that gets shared between the clock controller and
> the clock references in the dts.
> Add softreset ID for rk3128.
> And it also applies to the RK3126 SoC.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/rk3128-cru.h | 283 +++++++++++++++++++++++++++++++++
>  1 file changed, 283 insertions(+)
>  create mode 100644 include/dt-bindings/clock/rk3128-cru.h
> 
> diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
> new file mode 100644
> index 000000000000..5f055a41584b
> --- /dev/null
> +++ b/include/dt-bindings/clock/rk3128-cru.h

[...]

> +#define SCLK_USB480M		154
> +#define SCLK_USB480M_PHY	155

We probably don't need the clock-id for USB480M_PHY, as it is an external
clock and is unused. Instead as I wrote in the previous patch, it should
be added to the list of external clocks in the binding txt document.


Heiko
