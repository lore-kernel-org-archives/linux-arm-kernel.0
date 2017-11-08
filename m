From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Nov 2017 22:23:16 +0900
Subject: [PATCH] clk: uniphier: fix DAPLL2 clock rate of Pro5
In-Reply-To: <1507170779-26688-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507170779-26688-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARFsmaV=+OFnxRCJpYxmC8nuRQa6UhfdOMqgAOs_jWqVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Could you pick this up, please?


You sent a pull request last week.
So, queuing this for -next is fine for me.



2017-10-05 11:32 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The parent of DAPLL2 should be DAPLL1.  Fix the clock connection.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/clk/uniphier/clk-uniphier-sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
> index 0e396f3..bffe095 100644
> --- a/drivers/clk/uniphier/clk-uniphier-sys.c
> +++ b/drivers/clk/uniphier/clk-uniphier-sys.c
> @@ -123,7 +123,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
>  const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
>         UNIPHIER_CLK_FACTOR("spll", -1, "ref", 120, 1),         /* 2400 MHz */
>         UNIPHIER_CLK_FACTOR("dapll1", -1, "ref", 128, 1),       /* 2560 MHz */
> -       UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),     /* 2949.12 MHz */
> +       UNIPHIER_CLK_FACTOR("dapll2", -1, "dapll1", 144, 125),  /* 2949.12 MHz */
>         UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
>         UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
>         UNIPHIER_PRO5_SYS_CLK_NAND(2),
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
