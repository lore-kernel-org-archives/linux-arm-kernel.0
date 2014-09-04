From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 4 Sep 2014 08:50:40 +0000
Subject: [Patch net-next 08/11] net:fec: change FEC alignment to 64
 bytes for ARM platform
In-Reply-To: <1409776697-1536-9-git-send-email-Frank.Li@freescale.com>
References: <1409776697-1536-1-git-send-email-Frank.Li@freescale.com>
 <1409776697-1536-9-git-send-email-Frank.Li@freescale.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17487196@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li
> From: Fugang Duan <B38611@freescale.com>
> 
> Since enet-avb has 64 bytes alignment limitation for rx DMA transfer.
> The previous enet IP for ARM platform has 16 bytes alignment for tx
> DMA transfer.

Do you mean rx or tx here? or both??

And can we beat up the hardware designers to stop these restrictions
on rx (in particular) ethernet buffer alignments?
A device isn't suitable for ethernet unless is can write the destination
mac address to a 4n+2 boundary.

	David

> 64 is the an integral number of 16, so change alignment
> to 64 bytes for all ARM platform, which don't impact the performance
> of previous platform.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index a232245..b388e29f 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -65,7 +65,7 @@
>  static void set_multicast_list(struct net_device *ndev);
> 
>  #if defined(CONFIG_ARM)
> -#define FEC_ALIGNMENT	0xf
> +#define FEC_ALIGNMENT	0x3f
>  #else
>  #define FEC_ALIGNMENT	0x3
>  #endif
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
