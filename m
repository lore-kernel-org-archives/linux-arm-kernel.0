From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 May 2018 22:05:33 -0700
Subject: [PATCH v3 02/14] drivers: soc: sunxi: Add dedicated compatibles
 for the A13, A20 and A33
In-Reply-To: <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v67An8RSCKEDSgW_jY7m8iw22K4rRHb02q67decmCBcjhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2018 at 5:44 AM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This introduces platform-specific compatibles for the A13, A20 and A33
> SRAM driver. No particular adaptation for these platforms is required at
> this point, although this might become the case in the future.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/soc/sunxi/sunxi_sram.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 74cb81f37bd6..43ebc3bd33f2 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -315,6 +315,9 @@ static int sunxi_sram_probe(struct platform_device *pdev)
>
>  static const struct of_device_id sunxi_sram_dt_match[] = {
>         { .compatible = "allwinner,sun4i-a10-sram-controller" },
> +       { .compatible = "allwinner,sun5i-a13-sram-controller" },
> +       { .compatible = "allwinner,sun7i-a20-sram-controller" },
> +       { .compatible = "allwinner,sun8i-a33-sram-controller" },

We should probably name these "system-controller". Maxime?

ChenYu

>         { .compatible = "allwinner,sun50i-a64-sram-controller" },
>         { },
>  };
> --
> 2.16.3
>
