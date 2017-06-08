From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 8 Jun 2017 13:35:38 +0300
Subject: [PATCH v2 3/8] net: mvmdio: use GENMASK for masks
In-Reply-To: <20170608092653.25221-4-antoine.tenart@free-electrons.com>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-4-antoine.tenart@free-electrons.com>
Message-ID: <6b94a360-dcc7-a78c-819b-4f3c87cf3c6c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 6/8/2017 12:26 PM, Antoine Tenart wrote:

> Cosmetic patch to use the GENMASK helper for masks.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvmdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
> index 17b518b13ae3..96af8d57d9e5 100644
> --- a/drivers/net/ethernet/marvell/mvmdio.c
> +++ b/drivers/net/ethernet/marvell/mvmdio.c
> @@ -138,7 +138,7 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
>  		goto out;
>  	}
>
> -	ret = val & 0xFFFF;
> +	ret = val & GENMASK(15,0);

    Need a space after comma.

MBR, Sergei
