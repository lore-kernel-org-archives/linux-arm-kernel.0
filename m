From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 13 Mar 2013 11:00:19 +0530
Subject: [PATCH V2] ARM: dts: Modify SPI nodes according generic DMA DT
 bindings
In-Reply-To: <1362480394-1064-1-git-send-email-padma.v@samsung.com>
References: <1362480394-1064-1-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-Bc53K57YzrCA=js_=f5v5ssvfSv0Nee4hLYMesGFTp9pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tue, Mar 5, 2013 at 4:16 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> This patch removes custom way of adding spi dma channels and
> adds according to new generic DMA DT bindings on samsung exynos4
> and exynos5440 platforms.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>
> Changes since V1:
>         - Corrected the pdma phandle in spi1 node.
>
>  arch/arm/boot/dts/exynos4.dtsi    |   15 +++++++++------
>  arch/arm/boot/dts/exynos5440.dtsi |    5 +++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 1a62bcf..4521a72 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -235,8 +235,9 @@
>                 compatible = "samsung,exynos4210-spi";
>                 reg = <0x13920000 0x100>;
>                 interrupts = <0 66 0>;
> -               tx-dma-channel = <&pdma0 7>; /* preliminary */
> -               rx-dma-channel = <&pdma0 6>; /* preliminary */
> +               dmas = <&pdma0 7
> +                       &pdma0 6>;
> +               dma-names = "tx", "rx";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 status = "disabled";
> @@ -246,8 +247,9 @@
>                 compatible = "samsung,exynos4210-spi";
>                 reg = <0x13930000 0x100>;
>                 interrupts = <0 67 0>;
> -               tx-dma-channel = <&pdma1 7>; /* preliminary */
> -               rx-dma-channel = <&pdma1 6>; /* preliminary */
> +               dmas = <&pdma1 7
> +                       &pdma1 6>;
> +               dma-names = "tx", "rx";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 status = "disabled";
> @@ -257,8 +259,9 @@
>                 compatible = "samsung,exynos4210-spi";
>                 reg = <0x13940000 0x100>;
>                 interrupts = <0 68 0>;
> -               tx-dma-channel = <&pdma0 9>; /* preliminary */
> -               rx-dma-channel = <&pdma0 8>; /* preliminary */
> +               dmas = <&pdma0 9
> +                       &pdma0 8>;
> +               dma-names = "tx", "rx";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 status = "disabled";
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 9a99755..31a3626 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -79,8 +79,9 @@
>                 compatible = "samsung,exynos4210-spi";
>                 reg = <0xD0000 0x1000>;
>                 interrupts = <0 4 0>;
> -               tx-dma-channel = <&pdma0 5>; /* preliminary */
> -               rx-dma-channel = <&pdma0 4>; /* preliminary */
> +               dmas = <&pdma0 5
> +                       &pdma0 4>;
> +               dma-names = "tx", "rx";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>         };

Any comment on this patch? If not can you please take this into your tree?

Thanks
Padma
> --
> 1.7.4.4
>
