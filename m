From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Jul 2017 17:37:00 +0200 (CEST)
Subject: [PATCH V3 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <AM3PR04MB3066C526C5AB6138684393C80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1499176823-4421-1-git-send-email-aisheng.dong@nxp.com>
 <1499176823-4421-3-git-send-email-aisheng.dong@nxp.com>
 <alpine.DEB.2.20.1707041603571.9000@nanos>
 <AM3PR04MB3061653B4CF496CD1A4FAE280D70@AM3PR04MB306.eurprd04.prod.outlook.com>
 <alpine.DEB.2.20.1707041636050.9000@nanos>
 <AM3PR04MB3066C526C5AB6138684393C80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1707041736270.9000@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jul 2017, A.s. Dong wrote:
> +       /*
> +        * NOTE: We observed in a very small probability, the bus fabric
> +        * contention between GPU and A7 may results a few cycles delay
> +        * of writing CNT registers which may cause the min_delta event got
> +        * missed, so we need add a ETIME check here in case it happened.
> +        */
>         return (int)((next - now) <= 0) ? -ETIME : 0;
>  }
> 
> Do you think it's ok?

Looks about right.
