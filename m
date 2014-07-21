From: davem@davemloft.net (David Miller)
Date: Sun, 20 Jul 2014 21:12:32 -0700 (PDT)
Subject: [PATCH 1/6] net/macb: configure for FIFO mode and non-gigabit
In-Reply-To: <34adf38d52eb31e3ffd36149d320eb0872452bb1.1405689937.git.cyrille.pitchen@atmel.com>
References: <cover.1405689937.git.cyrille.pitchen@atmel.com>
 <34adf38d52eb31e3ffd36149d320eb0872452bb1.1405689937.git.cyrille.pitchen@atmel.com>
Message-ID: <20140720.211232.1172882419541843442.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Fri, 18 Jul 2014 16:21:13 +0200

> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> This addition will also allow to configure DMA burst length.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/net/ethernet/cadence/macb.c | 72 +++++++++++++++++++++++++++----------
>  drivers/net/ethernet/cadence/macb.h | 19 ++++++++--
>  2 files changed, 71 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
> index e9daa07..0896d88 100644
> --- a/drivers/net/ethernet/cadence/macb.c
> +++ b/drivers/net/ethernet/cadence/macb.c
> @@ -264,7 +264,8 @@ static void macb_handle_link_change(struct net_device *dev)
>  				reg |= MACB_BIT(FD);
>  			if (phydev->speed == SPEED_100)
>  				reg |= MACB_BIT(SPD);
> -			if (phydev->speed == SPEED_1000)
> +			if (phydev->speed == SPEED_1000
> +			 && bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)

Conditional operators end lines, they do not begin lines.

Also you must start the second and subsequent lines at the very
first column after the openning parenthesis of the first line.
