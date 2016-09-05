From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 5 Sep 2016 08:27:21 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: add sgtl5000 sound card
 support
In-Reply-To: <1473063707-31282-1-git-send-email-wente.wang@nxp.com>
References: <1473063707-31282-1-git-send-email-wente.wang@nxp.com>
Message-ID: <CAOMZO5CRQwOcHE1sHi35r6KjDvVh1Q5xTbBxL7gxZW2aNvgb6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Winter,

On Mon, Sep 5, 2016 at 5:21 AM, Winter Wang <wente.wang@nxp.com> wrote:
> use simple-audio-card to support sgtl5000 with SAI interface.

Is this really needed? Currently we get audio working via
sound/soc/fsl/fsl-asoc-card.c driver.

> diff --git a/arch/arm/boot/dts/imx6ul-pinfunc.h b/arch/arm/boot/dts/imx6ul-pinfunc.h
> index 0034eeb..3397b49 100644
> --- a/arch/arm/boot/dts/imx6ul-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6ul-pinfunc.h
> @@ -924,7 +924,7 @@
>  #define MX6UL_PAD_CSI_DATA06__ECSPI1_MOSI              0x01fc 0x0488 0x053c 3 1
>  #define MX6UL_PAD_CSI_DATA06__EIM_AD06                 0x01fc 0x0488 0x0000 4 0
>  #define MX6UL_PAD_CSI_DATA06__GPIO4_IO27               0x01fc 0x0488 0x0000 5 0
> -#define MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA             0x01fc 0x0488 0x0000 6 0
> +#define MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA             0x01fc 0x0488 0x05E4 6 1

This should be a separate change and you need to explain it.
