From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 11 Jun 2014 17:15:18 +0200
Subject: [PATCH] ARM: ux500: add some DB8500 DMA channel info
In-Reply-To: <1402476631-12860-1-git-send-email-linus.walleij@linaro.org>
References: <1402476631-12860-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFruyV2mOVFZZi6b0LEKuym9SmZp5dvOXM3dxECcWOtJBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 June 2014 10:50, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds some missing DMA channel information to the disabled
> MMC/SD/SDIO blocks number 3 and 5, and notes that the assignment
> of MSP channels vary with ASIC variant.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index e41eedca3ce3..9d2323020d34 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -875,6 +875,10 @@
>                         reg = <0x80119000 0x1000>;
>                         interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
>
> +                       dmas = <&dma 41 0 0x2>, /* Logical - DevToMem */
> +                              <&dma 41 0 0x0>; /* Logical - MemToDev */
> +                       dma-names = "rx", "tx";
> +
>                         clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
>                         clock-names = "sdi", "apb_pclk";
>
> @@ -901,6 +905,10 @@
>                         reg = <0x80008000 0x1000>;
>                         interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
>
> +                       dmas = <&dma 43 0 0x2>, /* Logical - DevToMem */
> +                              <&dma 43 0 0x0>; /* Logical - MemToDev */
> +                       dma-names = "rx", "tx";
> +
>                         clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
>                         clock-names = "sdi", "apb_pclk";
>
> @@ -929,6 +937,7 @@
>                         interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
>                         v-ape-supply = <&db8500_vape_reg>;
>
> +                       /* This DMA channel only exist on DB8500 v1 */
>                         dmas = <&dma 30 0 0x10>; /* Logical - MemToDev - HighPrio */
>                         dma-names = "tx";
>
> @@ -962,6 +971,7 @@
>                         interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
>                         v-ape-supply = <&db8500_vape_reg>;
>
> +                       /* This DMA channel only exist on DB8500 v2 */
>                         dmas = <&dma 30 0 0x12>; /* Logical - DevToMem - HighPrio */
>                         dma-names = "rx";
>
> --
> 1.9.3
>
