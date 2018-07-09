From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 9 Jul 2018 08:58:03 +0200
Subject: [PATCH] ARM: dts: da850: Add power-domains to CPPI 4.1 node
In-Reply-To: <20180704094432.5424-1-nsekhar@ti.com>
References: <20180704094432.5424-1-nsekhar@ti.com>
Message-ID: <CAMpxmJWCUn7Dcg3ygupnyFGyBdZ_DuuqmjLAh4UfP0ANSZeRfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-04 11:44 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> This adds the power-domains property to CPPI 4.1 node.
>
> The CPPI 4.1 DMA driver uses pm_runtime to manage the clocks,
> so it needs this property in order to find and enable the clock
> properly.
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Applies for v4.19/dt branch of my tree.
>
>  arch/arm/boot/dts/da850.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 9e05a5a709c0..07f215e7e5b8 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -637,6 +637,7 @@
>                                 interrupts = <58>;
>                                 #dma-cells = <2>;
>                                 #dma-channels = <4>;
> +                               power-domains = <&psc1 1>;
>                                 status = "okay";
>                         };
>                 };
> --
> 2.16.2
>

Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
