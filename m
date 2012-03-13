From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Mar 2012 09:39:30 -0500
Subject: [PATCH v1 3/5] ARM: imx28evk: add mmc dt support
In-Reply-To: <1331628428-24017-4-git-send-email-b29396@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-4-git-send-email-b29396@freescale.com>
Message-ID: <4F5F5C22.1080506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2012 03:47 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |   14 ++++++++++++++
>  arch/arm/boot/dts/imx28.dtsi    |   33 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/imx28-dt.c    |    2 ++
>  3 files changed, 49 insertions(+), 0 deletions(-)

snip

> diff --git a/arch/arm/mach-mxs/imx28-dt.c b/arch/arm/mach-mxs/imx28-dt.c
> index 78d1129..429b88e 100644
> --- a/arch/arm/mach-mxs/imx28-dt.c
> +++ b/arch/arm/mach-mxs/imx28-dt.c
> @@ -23,6 +23,8 @@ static const struct of_dev_auxdata imx28_auxdata_lookup[] __initconst = {
>  	OF_DEV_AUXDATA("arm,pl011", MX28_DUART_BASE_ADDR, "duart", NULL),
>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC0_BASE_ADDR, "imx28-fec.0", NULL),
>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC1_BASE_ADDR, "imx28-fec.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP0_BASE_ADDR, "mxs-mmc.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP1_BASE_ADDR, "mxs-mmc.1", NULL),

Why is this needed?

>  	{ /* sentinel */ }
>  };
>  
