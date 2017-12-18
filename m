From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 18 Dec 2017 11:21:04 +0800
Subject: [PATCH 3/5] arm: dts: sun8i: a83t: Add the ir pin for the A83T
In-Reply-To: <20171217224547.21481-4-embed3d@gmail.com>
References: <20171217224547.21481-1-embed3d@gmail.com>
 <20171217224547.21481-4-embed3d@gmail.com>
Message-ID: <CAGb2v65Dcd=g+_Vv9b7q+eoEBhem7tzkrG8h1AeS7mF9bESNZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 6:45 AM, Philipp Rossak <embed3d@gmail.com> wrote:
> The CIR Pin of the A83T is located at PL12.
>
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index a384b766f3dc..954c2393325f 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -521,6 +521,11 @@
>                                 drive-strength = <20>;
>                                 bias-pull-up;
>                         };
> +
> +                       ir_pins_a: ir at 0 {

ir_pins: ir-pins

And it really should be cir, to distinguish it from IrDA.

ChenYu

> +                               pins = "PL12";
> +                               function = "s_cir_rx";
> +                       };
>                 };
>
>                 r_rsb: rsb at 1f03400 {
> --
> 2.11.0
>
