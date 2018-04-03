From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Apr 2018 17:07:06 +0800
Subject: [PATCH v5 05/13] ARM: dts: sun8i: Add R_CPUCFG device node for
 the A83T dtsi
In-Reply-To: <20180403061836.3926-6-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-6-mylene.josserand@bootlin.com>
Message-ID: <CAGb2v66w3349h0b+xRD8seHhqMNoue8AzAFr-UPKvzZAtvoV5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> The R_CPUCFG is a collection of registers needed for SMP bringup
> on clusters and cluster's reset.
> For the moment, documentation about this register is found in
> Allwinner's code only.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 32992afa0b12..85f14f4ebeed 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -933,6 +933,11 @@
>                         #reset-cells = <1>;
>                 };
>
> +               r_cpucfg at 1f01c00 {
> +                       compatible = "allwinner,sun8i-a83t-r-cpucfg";
> +                       reg = <0x1f01c00 0x100>;

The memory map says that its size is 0x400.

ChenYu
