From: prasannapadubidri@gmail.com (Prasanna Kumar)
Date: Tue, 22 Jan 2013 19:15:37 +0530
Subject: [PATCH 2/2] ARM: dts: exynos5: Set up power domain for MFC and
 G-scaler
In-Reply-To: <1357733733-18769-3-git-send-email-prasanna.ps@samsung.com>
References: <1357733733-18769-1-git-send-email-prasanna.ps@samsung.com>
 <1357733733-18769-3-git-send-email-prasanna.ps@samsung.com>
Message-ID: <CAPmaG0tnqm07br_d76MB2C3FJ5Ryt96r9oLK87pvFjDO+gGRMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Kindly review this patch.

On Wed, Jan 9, 2013 at 5:45 PM, Prasanna Kumar <prasanna.ps@samsung.com> wrote:
> This patch adds device tree nodes for MFC and G-scaler power domains
> of exynos5.It binds these power-domain nodes to repsective device tree nodes.
>
> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 30485de..6d0e87c 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -85,6 +85,7 @@
>                 compatible = "samsung,mfc-v6";
>                 reg = <0x11000000 0x10000>;
>                 interrupts = <0 96 0>;
> +               samsung,power-domain = <&pd_mfc>;
>         };
>
>         rtc {
> @@ -554,28 +555,42 @@
>                 };
>         };
>
> +       pd_gsc: gsc-power-domain at 0x10044000 {
> +               compatible = "samsung,exynos4210-pd";
> +               reg = <0x10044000 0x20>;
> +       };
> +
> +       pd_mfc: mfc-power-domain at 0x10044040 {
> +               compatible = "samsung,exynos4210-pd";
> +               reg = <0x10044040 0x20>;
> +       };
> +
>         gsc_0:  gsc at 0x13e00000 {
>                 compatible = "samsung,exynos5-gsc";
>                 reg = <0x13e00000 0x1000>;
>                 interrupts = <0 85 0>;
> +               samsung,power-domain = <&pd_gsc>;
>         };
>
>         gsc_1:  gsc at 0x13e10000 {
>                 compatible = "samsung,exynos5-gsc";
>                 reg = <0x13e10000 0x1000>;
>                 interrupts = <0 86 0>;
> +               samsung,power-domain = <&pd_gsc>;
>         };
>
>         gsc_2:  gsc at 0x13e20000 {
>                 compatible = "samsung,exynos5-gsc";
>                 reg = <0x13e20000 0x1000>;
>                 interrupts = <0 87 0>;
> +               samsung,power-domain = <&pd_gsc>;
>         };
>
>         gsc_3:  gsc at 0x13e30000 {
>                 compatible = "samsung,exynos5-gsc";
>                 reg = <0x13e30000 0x1000>;
>                 interrupts = <0 88 0>;
> +               samsung,power-domain = <&pd_gsc>;
>         };
>
>         hdmi {
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Prasanna Kumar
