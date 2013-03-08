From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 8 Mar 2013 21:25:00 +0100
Subject: [PATCH 5/9] ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
In-Reply-To: <1362763654-9660-6-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
 <1362763654-9660-6-git-send-email-jon-hunter@ti.com>
Message-ID: <CABxcv==OKX4z8x7ztqDJ5CozNmTQ5UaD43mTLWfQuqUt-y7xcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 8, 2013 at 6:27 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Add the device-tree node for GPMC on OMAP2, OMAP4 and OMAP5 devices.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/omap2430.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   11 +++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   11 +++++++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> index af65609..d4ce6c2 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -29,6 +29,17 @@
>                         pinctrl-single,function-mask = <0x3f>;
>                 };
>
> +               gpmc: gpmc at 6800a000 {
> +                       compatible = "ti,omap2420-gpmc";
> +                       reg = <0x6800a000 0x1000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <1>;
> +                       interrupts = <20>;
> +                       gpmc,num-cs = <8>;
> +                       gpmc,num-waitpins = <4>;
> +                       ti,hwmods = "gpmc";
> +               };
> +
>                 mcbsp1: mcbsp at 48074000 {
>                         compatible = "ti,omap2420-mcbsp";
>                         reg = <0x48074000 0xff>;
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> index c392445..832f184 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -29,6 +29,17 @@
>                         pinctrl-single,function-mask = <0x3f>;
>                 };
>
> +               gpmc: gpmc at 6e000000 {
> +                       compatible = "ti,omap2430-gpmc";
> +                       reg = <0x6e000000 0x1000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <1>;
> +                       interrupts = <20>;
> +                       gpmc,num-cs = <8>;
> +                       gpmc,num-waitpins = <4>;
> +                       ti,hwmods = "gpmc";
> +               };
> +
>                 mcbsp1: mcbsp at 48074000 {
>                         compatible = "ti,omap2430-mcbsp";
>                         reg = <0x48074000 0xff>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 827f6f3..726ef11 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -196,6 +196,17 @@
>                         #interrupt-cells = <1>;
>                 };
>
> +               gpmc: gpmc at 50000000 {
> +                       compatible = "ti,omap4430-gpmc";
> +                       reg = <0x50000000 0x1000>;

Hi Jon,

By looking at the GPMC Register Summary from both the OMAP4460 and OMAP OMAP35x
Technical Reference Manuals I see that the GPMC register address space
is only 720 bytes length. From base address + 0x0 to base address +
0x02d0.

So shouldn't the regs property be <0x50000000 0x2d0> instead?

Of course are only a few kilobytes but still I wonder if it makes
sense to map them when they are not going to be used.

Best regards,
Javier
