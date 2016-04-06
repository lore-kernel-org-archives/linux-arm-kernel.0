From: fugang.duan@nxp.com (Fugang Duan)
Date: Wed, 6 Apr 2016 09:10:30 +0000
Subject: [PATCH net-next V3 02/16] net: fec: remove unused interrupt
 FEC_ENET_TS_TIMER
In-Reply-To: <1459909562-22865-3-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
 <1459909562-22865-3-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB1855BC1C6A65516245790BA3FF9F0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Wednesday, April 06, 2016 10:26 AM
> To: netdev at vger.kernel.org; davem at davemloft.net; Fugang Duan
> <fugang.duan@nxp.com>; lznuaa at gmail.com
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; l.stach at pengutronix.de;
> andrew at lunn.ch; tremyfr at gmail.com; gerg at uclinux.org; linux-arm-
> kernel at lists.infradead.org; johannes at sipsolutions.net;
> stillcompiling at gmail.com; sergei.shtylyov at cogentembedded.com;
> arnd at arndb.de; Troy Kisky <troy.kisky@boundarydevices.com>
> Subject: [PATCH net-next V3 02/16] net: fec: remove unused interrupt
> FEC_ENET_TS_TIMER
> 
> FEC_ENET_TS_TIMER is not checked in the interrupt routine so there is no need
> to enable it.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> ---
> v3: New patch
> 
> Frank Li said "TS_TIMER should never be triggered."
> when discussing another patch.
> ---
>  drivers/net/ethernet/freescale/fec.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 195122e..6dd0ba8 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -374,8 +374,8 @@ struct bufdesc_ex {
>  #define FEC_ENET_TS_AVAIL       ((uint)0x00010000)
>  #define FEC_ENET_TS_TIMER       ((uint)0x00008000)
> 
> -#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII
> | FEC_ENET_TS_TIMER)
> -#define FEC_NAPI_IMASK	(FEC_ENET_MII | FEC_ENET_TS_TIMER)
> +#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII)
> +#define FEC_NAPI_IMASK	FEC_ENET_MII
>  #define FEC_RX_DISABLED_IMASK (FEC_DEFAULT_IMASK & (~FEC_ENET_RXF))
> 
>  /* ENET interrupt coalescing macro define */
> --
> 2.5.0

Acked-by: Fugang Duan <fugang.duan@nxp.com>
