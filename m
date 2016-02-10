From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 10 Feb 2016 00:41:30 +0000
Subject: [PATCH v2 5/5] ARM: dts: r8a7794: add sound support
In-Reply-To: <2543047.yYrDdYb9v5@wasted.cogentembedded.com>
References: <12033353.rt0nolnBmD@wasted.cogentembedded.com>
 <2543047.yYrDdYb9v5@wasted.cogentembedded.com>
Message-ID: <874mdhtn7d.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

Sorry for my un-ordered response

> Define the generic R8A7794 part of  the sound device node.
> This sound device  is a complex one and comprises the Audio Clock Generator
> (ADG), Sampling Rate Converter Unit (SCU), Serial Sound Interface [Unit]
> (SSI[U]), and Audio DMAC-Peripheral-Peripheral.
> It is up  to the board file to enable the device.
> 
> This patch is based on the R8A7791 sound work by Kuninori Morimoto.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
(snip)
> +		rcar_sound,src {
> +			src1: src at 1 {
> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&audma0 0x87>, <&audma0 0x9c>;
> +				dma-names = "rx", "tx";
> +			};
> +			src2: src at 2 {
> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&audma0 0x89>, <&audma0 0x9e>;
> +				dma-names = "rx", "tx";
> +			};
> +			src3: src at 3 {
> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&audma0 0x8b>, <&audma0 0xa0>;
> +				dma-names = "rx", "tx";
> +			};
> +			src4: src at 4 {
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&audma0 0x8d>, <&audma0 0xb0>;
> +				dma-names = "rx", "tx";
> +			};
> +			src5: src at 5 {
> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&audma0 0x8f>, <&audma0 0xb2>;
> +				dma-names = "rx", "tx";
> +			};
> +			src6: src at 6 {
> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&audma0 0x91>, <&audma0 0xb4>;
> +				dma-names = "rx", "tx";
> +			};
> +		};

I think this can't work correctly, because driver is assuming
DT has all channles (from 0). (see linux/sound/soc/sh/rcar/src.c :: rsnd_src_probe)
Can you adds dummy src0 with some comments ? or fix src.c driver ?
