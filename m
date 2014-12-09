From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Dec 2014 09:59:42 +0100
Subject: [PATCH 1/2] clk: bcm: kona: don't return -EFOO as bool
In-Reply-To: <1418075645-14571-1-git-send-email-olof@lixom.net>
References: <1418075645-14571-1-git-send-email-olof@lixom.net>
Message-ID: <13166134.ThBvWAfRgN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 13:54:04 Olof Johansson wrote:
> diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
> index 95af2e6..53fca77 100644
> --- a/drivers/clk/bcm/clk-kona.c
> +++ b/drivers/clk/bcm/clk-kona.c
> @@ -1252,7 +1252,7 @@ static bool __kona_clk_init(struct kona_clk *bcm_clk)
>         default:
>                 BUG();
>         }
> -       return -EINVAL;
> +       return false;
>  }

Nothing wrong with your patch, but the __kona_clk_init() function is
still very strange. Note that the return statement is unreachable,
and the reason for the BUG() statement to not be hit is that all
kona clocks have type=bcm_clk_peri.

	Arnd
