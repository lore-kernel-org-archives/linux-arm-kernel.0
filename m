From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 16 Oct 2013 22:41:44 -0700
Subject: [RESEND PATCH v2 2/6] ARM: dts: Specify clocks for UARTs on
 bcm11351
In-Reply-To: <1381960030-1640-3-git-send-email-tim.kryger@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
 <1381960030-1640-3-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYrzAow1yr58jOp5ead7BkQx-K7yaLLzSHPwqYVu=aZFEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 2:47 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Rather than declaring the frequency of the external clock, specify the
> label of the clock such that the driver may determine the frequency on
> its own.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index c6464fb..ce65367 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -43,7 +43,7 @@
>                 compatible = "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
>                 status = "disabled";
>                 reg = <0x3e000000 0x1000>;
> -               clock-frequency = <13000000>;
> +               clocks = <&uartb_clk>;
>                 interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>                 reg-shift = <2>;
>                 reg-io-width = <4>;

Hi Sebastian,
 this patch series (and a subsequent one from Tim) both rely on your
"ARM: provide common arch init for DT clocks" patchset in order to
work. Will that patchset be in 3.13 ? I don't want to pull the dt mods
unless they are as they break the boot without them.

 Thanks,
   csd
