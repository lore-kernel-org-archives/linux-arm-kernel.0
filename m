From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 15:48:49 -0700
Subject: [PATCH] clk: sunxi: "cpu_data" is defined in header files of some
 architectures
In-Reply-To: <1368798200-7063-1-git-send-email-emilio@elopez.com.ar>
References: <5195D615.70608@cateee.net>
 <1368798200-7063-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130529224849.6058.25112@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-05-17 06:43:20)
> From: "Giacomo A. Catenazzi" <cate@cateee.net>
> 
> In some architectures, the #define cpu_data is not a "macro-function",
> so the compiler will substitute the identifier with probably something
> wrong.
> 
> Signed-off-by: Giacomo A. Catenazzi <cate@cateee.net>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> [emilio at elopez.com.ar: use cpu_mux_data instead of this_cpu_data]

Taken into clk-next.

Regards,
Mike

> ---
> 
> Hi Giacomo,
> 
> I have taken your patch and resent it to linux-arm-kernel and Mike 
> Turquette this time, but please try to use git send-email on your next 
> patch.
> 
> Here is a video from Greg that explains how to use it as well as other 
> things (checkpatch.pl, get_maintainer.pl, etc)
> 
> http://www.youtube.com/watch?v=LLBrBBImJt4
> 
> Thanks! :)
> 
> Emilio
> 
>  drivers/clk/sunxi/clk-sunxi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 930d36f..412912b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -239,7 +239,7 @@ struct mux_data {
>         u8 shift;
>  };
>  
> -static const __initconst struct mux_data cpu_data = {
> +static const __initconst struct mux_data cpu_mux_data = {
>         .shift = 16,
>  };
>  
> @@ -433,7 +433,7 @@ static const __initconst struct of_device_id clk_div_match[] = {
>  
>  /* Matches for mux clocks */
>  static const __initconst struct of_device_id clk_mux_match[] = {
> -       {.compatible = "allwinner,sun4i-cpu-clk", .data = &cpu_data,},
> +       {.compatible = "allwinner,sun4i-cpu-clk", .data = &cpu_mux_data,},
>         {.compatible = "allwinner,sun4i-apb1-mux-clk", .data = &apb1_mux_data,},
>         {}
>  };
> -- 
> 1.8.2.3
