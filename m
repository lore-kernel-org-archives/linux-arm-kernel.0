From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 12 Jul 2018 10:46:19 -0300
Subject: [PATCH] ARM: dts: imx6sl: Add vivante gpu nodes
In-Reply-To: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
References: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5Dek84qTDUHApYhk2RofuqbG6YuKzJ4XRHfOcKLe1nS+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Thu, Jul 12, 2018 at 10:37 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index a6bc21433839..49a56b4fd393 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -130,10 +130,30 @@
>                         cache-level = <2>;
>                         arm,tag-latency = <4 2 3>;
>                         arm,data-latency = <4 2 3>;
>                 };
>
> +               gpu_2d: gpu at 2200000 {
> +                       compatible = "vivante,gc";
> +                       reg = <0x02200000 0x4000>;
> +                       interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +                                <&clks IMX6SL_CLK_GPU2D_OVG>;
> +                       clock-names = "bus", "core";
> +                       power-domains = <&pd_pu>;
> +               };
> +
> +               gpu_vg: gpu at 2204000 {
> +                       compatible = "vivante,gc";
> +                       reg = <0x02204000 0x4000>;
> +                       interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
> +                                <&clks IMX6SL_CLK_GPU2D_OVG>;
> +                       clock-names = "bus", "core";
> +                       power-domains = <&pd_pu>;
> +               };
> +
>                 aips1: aips-bus at 2000000 {

We try to keep the peripherals sorted by address range in dtsi, so
please put the gpu nodes below aips2.
