From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 12 Nov 2011 13:49:39 +0100
Subject: [PATCH 1/1] net: fec: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320901304-13157-1-git-send-email-richard.zhao@linaro.org>
References: <1320901304-13157-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111112124939.GJ5011@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Thu, Nov 10, 2011 at 01:01:44PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  drivers/net/ethernet/freescale/fec.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index 1124ce0..92e3585 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -1588,6 +1588,7 @@ fec_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(fep->clk);
>  		goto failed_clk;
>  	}
> +	clk_prepare(fep->clk);
What about error checking?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
