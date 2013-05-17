From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 16:10:43 +0800
Subject: [PATCH] ARM: imx23-olinuxino: Add i2c support
In-Reply-To: <1368766213-16487-1-git-send-email-f.koliqi@gmail.com>
References: <1368766213-16487-1-git-send-email-f.koliqi@gmail.com>
Message-ID: <20130517081042.GF8607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 12:50:13AM -0400, Fadil Berisha wrote:
> -			i2c at 80058000 {
> +			i2c: i2c at 80058000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx28-i2c";
>  				reg = <0x80058000 0x2000>;
>  				dmas = <&dma_apbx 3>;
>  				dma-names = "rx-tx";
> +				interrupts = <27 26>;
> +				clock-frequency = <100000>;
> +				fsl,i2c-dma-channel = <3>;

As we have adopted generic DMA bindings, this custom property shouldn't
be needed now.

Shawn

>  				status = "disabled";
>  			};
>  
> -- 
> 1.7.10
> 
