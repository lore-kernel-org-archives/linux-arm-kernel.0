From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Mon, 4 Jun 2018 14:13:16 +0200
Subject: [PATCH v3 5/8] media: rcar-vin: Handle data-enable polarity
In-Reply-To: <1527606359-19261-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-6-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180604121316.GF19674@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

Thanks for your work.

On 2018-05-29 17:05:56 +0200, Jacopo Mondi wrote:
> Handle data-enable signal polarity. If the polarity is not specifically
> requested to be active low, use the active high default.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v3:
> - use new property to set the CES bit
> ---
>  drivers/media/platform/rcar-vin/rcar-dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
> index d2b7002..9145b56 100644
> --- a/drivers/media/platform/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/rcar-vin/rcar-dma.c
> @@ -123,6 +123,7 @@
>  /* Video n Data Mode Register 2 bits */
>  #define VNDMR2_VPS		(1 << 30)
>  #define VNDMR2_HPS		(1 << 29)
> +#define VNDMR2_CES		(1 << 28)
>  #define VNDMR2_FTEV		(1 << 17)
>  #define VNDMR2_VLV(n)		((n & 0xf) << 12)
> 
> @@ -698,6 +699,10 @@ static int rvin_setup(struct rvin_dev *vin)
>  		/* Vsync Signal Polarity Select */
>  		if (!(vin->parallel->mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW))
>  			dmr2 |= VNDMR2_VPS;
> +
> +		/* Data Enable Polarity Select */
> +		if (vin->parallel->mbus_flags & V4L2_MBUS_DATA_ENABLE_LOW)
> +			dmr2 |= VNDMR2_CES;
>  	}
> 
>  	/*
> --
> 2.7.4
> 

-- 
Regards,
Niklas S?derlund
