From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 21 Oct 2015 02:30:51 -0700
Subject: [PATCH v2 4/4] clk: berlin: bg2: remove CLK_IGNORE_UNUSED flag
 for sdio clk
In-Reply-To: <1445339807-2351-5-git-send-email-jszhang@marvell.com>
References: <1445339807-2351-1-git-send-email-jszhang@marvell.com>
 <1445339807-2351-5-git-send-email-jszhang@marvell.com>
Message-ID: <20151021093051.20687.11262@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jisheng Zhang (2015-10-20 04:16:47)
> The clocks' properties have been already properly set, so there's no
> need to set this flag for sdio0 and sdio1 clk any more.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/berlin/bg2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
> index 73153fc..23e0e3b 100644
> --- a/drivers/clk/berlin/bg2.c
> +++ b/drivers/clk/berlin/bg2.c
> @@ -490,8 +490,8 @@ static const struct berlin2_gate_data bg2_gates[] __initconst = {
>         { "usb0",       "perif",        11 },
>         { "usb1",       "perif",        12 },
>         { "pbridge",    "perif",        13, CLK_IGNORE_UNUSED },
> -       { "sdio0",      "perif",        14, CLK_IGNORE_UNUSED },
> -       { "sdio1",      "perif",        15, CLK_IGNORE_UNUSED },
> +       { "sdio0",      "perif",        14 },
> +       { "sdio1",      "perif",        15 },
>         { "nfc",        "perif",        17 },
>         { "smemc",      "perif",        19 },
>         { "audiohd",    "audiohd_pll",  26 },
> -- 
> 2.6.1
> 
