From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 19 Nov 2018 12:29:07 -0600
Subject: [PATCH 08/16] arm: dts: rda8810pl: Add interrupt controller
 support
In-Reply-To: <20181119170939.19153-9-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-9-manivannan.sadhasivam@linaro.org>
Message-ID: <CAL_JsqL3B3y3hYv-yf3wzXiUsvnM9pCYE7u_Y0i4zT7wFti5GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 11:11 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add interrupt controller support for RDA Micro RDA8810PL SoC.

There's no point in splitting this to a separate patch. Without it,
the DT is not functional.

> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/rda8810pl.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
> index 7f1ff2021eff..093d6980bfbd 100644
> --- a/arch/arm/boot/dts/rda8810pl.dtsi
> +++ b/arch/arm/boot/dts/rda8810pl.dtsi
> @@ -9,6 +9,7 @@
>
>  / {
>         compatible = "rda,8810pl";
> +       interrupt-parent = <&intc>;
>         #address-cells = <1>;
>         #size-cells = <1>;
>
> @@ -49,6 +50,13 @@
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges = <0x0 0x20800000 0x100000>;
> +
> +                       intc: interrupt-controller {


unit-address?

> +                               compatible = "rda,8810pl-intc";
> +                               reg = <0x0 0x1000>;
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +                       };
>                 };
>
>                 apb at 20900000 {
> --
> 2.17.1
>
