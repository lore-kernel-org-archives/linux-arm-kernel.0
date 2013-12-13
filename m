From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Dec 2013 16:39:17 +0800
Subject: [PATCH 2/4] ARM: dts: imx6qdl: add pingroup for enet interface
 in RMII mode
In-Reply-To: <1386854880-21805-3-git-send-email-LW@KARO-electronics.de>
References: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
 <1386854880-21805-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <20131213083915.GS18380@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:27:58PM +0100, Lothar Wa?mann wrote:
> This will be used by the TX6 modules from Ka-Ro electronics.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx6qdl-pingrp.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-pingrp.h b/arch/arm/boot/dts/imx6qdl-pingrp.h
> index 8d71b13..4932249 100644
> --- a/arch/arm/boot/dts/imx6qdl-pingrp.h
> +++ b/arch/arm/boot/dts/imx6qdl-pingrp.h
> @@ -100,6 +100,17 @@
>  	MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b0b0 \
>  	MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN		0x1b0b0
>  
> +#define MX6QDL_ENET_PINGRP4					\

The '\' should just be after MX6QDL_ENET_PINGRP4 with a space in
between.

I just fixed it up and applied the first 3 patches.

Shawn

> +	MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b0b0	\
> +	MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b0b0	\
> +	MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0		0x1b0b0	\
> +	MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1		0x1b0b0	\
> +	MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER		0x1b0b0	\
> +	MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN		0x1b0b0	\
> +	MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0		0x1b0b0	\
> +	MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1		0x1b0b0	\
> +	MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN		0x1b0b0
> +
>  #define MX6QDL_ESAI_PINGRP1 \
>  	MX6QDL_PAD_ENET_RXD0__ESAI_TX_HF_CLK		0x1b030 \
>  	MX6QDL_PAD_ENET_CRS_DV__ESAI_TX_CLK		0x1b030 \
> -- 
> 1.7.2.5
> 
