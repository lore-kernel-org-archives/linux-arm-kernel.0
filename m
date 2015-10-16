From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 16 Oct 2015 05:47:05 -0700
Subject: [PATCH 4/5] clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for
 sdio clk
In-Reply-To: <1444628796-5484-5-git-send-email-jszhang@marvell.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
 <1444628796-5484-5-git-send-email-jszhang@marvell.com>
Message-ID: <20151016124705.20687.51712@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jisheng Zhang (2015-10-11 22:46:35)
> Since we have added the necessary axi clk properties in dts, we can
> remove the "sdio" clk's CLK_IGNORE_UNUSED flag now.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/berlin/bg2q.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
> index 221f40c..243f421 100644
> --- a/drivers/clk/berlin/bg2q.c
> +++ b/drivers/clk/berlin/bg2q.c
> @@ -283,7 +283,7 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
>         { "usb2",       "perif",        13 },
>         { "usb3",       "perif",        14 },
>         { "pbridge",    "perif",        15, CLK_IGNORE_UNUSED },
> -       { "sdio",       "perif",        16, CLK_IGNORE_UNUSED },
> +       { "sdio",       "perif",        16 },
>         { "nfc",        "perif",        18 },
>         { "pcie",       "perif",        22 },
>  };
> -- 
> 2.6.1
> 
