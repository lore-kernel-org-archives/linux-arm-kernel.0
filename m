From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 11:21:30 +0800
Subject: [PATCH v1] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <1410312816-32171-1-git-send-email-b38343@freescale.com>
References: <1410312816-32171-1-git-send-email-b38343@freescale.com>
Message-ID: <20140910032128.GD18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 09:33:36AM +0800, Robin Gong wrote:
> There is one weird data in rxfifo after one full rx/tx transfer
> done sometimes. It looks a design issue and hard to workaround
> totally, so disable dma functhion here. And will re-enable it
> once the root cause found.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index b453e0e..e84a1ff 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -102,6 +102,22 @@
>  	};
>  };
>  
> +&ecspi1 {
> +	dma-names = "", "";
> +};
> +
> +&ecspi2 {
> +	dma-names = "", "";
> +};
> +
> +&ecspi3 {
> +	dma-names = "", "";
> +};
> +
> +&ecspi4 {
> +	dma-names = "", "";
> +};
> +

This looks odd.  Can we drop the dma properties from imx6qdl.dtsi,
and only add them in imx6q.dtsi instead?

Shawn

>  &hdmi {
>  	compatible = "fsl,imx6dl-hdmi";
>  };
> -- 
> 1.9.1
> 
