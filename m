From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 12 Mar 2013 14:23:00 +0530
Subject: [PATCH 2/4] clk: samsung: remove np check in clock init
In-Reply-To: <201303120044.00803.heiko@sntech.de>
References: <201303120042.09633.heiko@sntech.de>
 <201303120044.00803.heiko@sntech.de>
Message-ID: <CAJuYYwSU_pFoyHkzt=sP6AfN03F9V1_Rx+3o1ekbLHD4jC5SpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2013 05:14, Heiko St?bner <heiko@sntech.de> wrote:
> This let to the suspend init never being reached on non-DT platforms.
>
> Signed-off-by: Heiko Stueber <heiko@sntech.de>
> ---
>  drivers/clk/samsung/clk.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index d36cdd5..1a5de69 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -57,8 +57,6 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
>                 unsigned long nr_rdump)
>  {
>         reg_base = base;
> -       if (!np)
> -               return;

Hi Heiko,

Sorry, I did not understand the need for this. Could you please add
few more details on this change.

Thanks,
Thomas.

>
>  #ifdef CONFIG_OF
>         clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
> --
> 1.7.2.3
>
