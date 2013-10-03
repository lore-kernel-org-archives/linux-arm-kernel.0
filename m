From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 2 Oct 2013 22:54:30 -0700
Subject: [PATCH] ARM: DT: Add missing UARTs for bcm11351 (bcm281xx)
In-Reply-To: <1379958597-8554-1-git-send-email-tim.kryger@linaro.org>
References: <1379958597-8554-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYrFvJjSUeA_opTTy5-fErfVFD19BOx3H4C_0R-N903Fvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 10:49 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> This adds in three more UARTs that were not declared earlier.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 05a5aab..98e6bc0 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -49,6 +49,36 @@
>                 reg-io-width = <4>;
>         };
>
> +       uart at 3e001000 {
> +               compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
> +               status = "disabled";
> +               reg = <0x3e001000 0x1000>;
> +               clock-frequency = <13000000>;
> +               interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +               reg-shift = <2>;
> +               reg-io-width = <4>;
> +       };
> +
> +       uart at 3e002000 {
> +               compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
> +               status = "disabled";
> +               reg = <0x3e002000 0x1000>;
> +               clock-frequency = <13000000>;
> +               interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> +               reg-shift = <2>;
> +               reg-io-width = <4>;
> +       };
> +
> +       uart at 3e003000 {
> +               compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
> +               status = "disabled";
> +               reg = <0x3e003000 0x1000>;
> +               clock-frequency = <13000000>;
> +               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +               reg-shift = <2>;
> +               reg-io-width = <4>;
> +       };
> +
>         L2: l2-cache {
>                 compatible = "brcm,bcm11351-a2-pl310-cache";
>                 reg = <0x3ff20000 0x1000>;
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
Applied to armsoc/for-3.13/dt.

 thanks,
   csd
