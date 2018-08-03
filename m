From: yixun.lan@gmail.com (Yixun Lan)
Date: Fri, 3 Aug 2018 21:50:25 +0800
Subject: [PATCH 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
In-Reply-To: <20180801185128.23440-4-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-4-maxi.jourdan@wanadoo.fr>
Message-ID: <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime

great job! thanks for contributing the patches..

On Thu, Aug 2, 2018 at 2:51 AM, Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
> Wrap the canvas node in a syscon node.
>
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index b8dc4dbb391b..d104b9e111fb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -423,6 +423,23 @@
>                         };
>                 };
>
> +               dmcbus: bus at c8838000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x0 0xc8838000 0x0 0x1000>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
> +
> +                       sysctrl_DMC: system-controller at 0 {
> +                               compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";

we'd like to drop 'meson-' prefix, so better using "amlogic,gx-dmc-sysctrl",
please take a look at the discussion here [1]

[1] https://lkml.kernel.org/r/7hk1prmg4w.fsf at baylibre.com

> +                               reg = <0x0 0x0 0x0 0x1000>;
> +
> +                               canvas: canvas-provider at 0 {
> +                                       compatible = "amlogic,meson-canvas";
ditto

> +                               };
> +                       };
> +               };
> +
>                 hiubus: bus at c883c000 {
>                         compatible = "simple-bus";
>                         reg = <0x0 0xc883c000 0x0 0x2000>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
