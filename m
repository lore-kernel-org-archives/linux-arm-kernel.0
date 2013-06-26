From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 26 Jun 2013 18:51:53 +0200
Subject: [PATCH v2 6/8] ARM: dts: Add camera subsystem nodes to
 exynos4x12.dtsi
In-Reply-To: <19E27FB8C8BBCC47BD08BAF8EB69E51E0FFD8601@ex1.seri.co.uk>
References: <1372097151-18122-1-git-send-email-s.nawrocki@samsung.com>
 <1372097151-18122-7-git-send-email-s.nawrocki@samsung.com>
 <19E27FB8C8BBCC47BD08BAF8EB69E51E0FFD8601@ex1.seri.co.uk>
Message-ID: <51CB1C29.80908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/25/2013 10:24 AM, Phil Carmody wrote:
> Sylwester Nawrocki wrote:
> 
> Add common camera node and Exynos4212/4412 specific nodes for
> FIMC, MIPI-CSIS, FIMC-LITE and FIMC-IS devices.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi |  118 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 0e24d85..f8cc1d0 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -26,6 +26,8 @@
>                 pinctrl1 = &pinctrl_1;
>                 pinctrl2 = &pinctrl_2;
>                 pinctrl3 = &pinctrl_3;
> +               fimc-lite0 = &fimc_lite_0;
> +               fimc-lite1 = &fimc_lite_1;
>         };
> 
>         pd_isp: isp-power-domain at 10023CA0 {
> @@ -78,4 +80,120 @@
>                 clock-names = "sclk_fimg2d", "fimg2d";
>                 status = "disabled";
>         };
> +
> +       camera {
> +               clocks = <&clock 132>, <&clock 133>, <&clock 351>, <&clock 352>,
> +                        <&clock 388>, <&clock 389>, <&clock 17>;
> +               clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0",
> +                           "pxl_async1", "mux_cam0", "mux_cam1", "parent";
> +
> +               fimc_0: fimc at 11800000 {
> +                       compatible = "samsung,exynos4212-fimc";
> +                       clocks = <&clock 256>, <&clock 128>, <&clock 384>, <&clock 17>;
> +                       clock-names = "fimc", "sclk_fimc", "mux", "parent";
> +                       samsung,pix-limits = <4224 8192 1920 4224>;
> +                       samsung,mainscaler-ext;
> +                       samsung,isp-wb;
> +                       samsung,cam-if;
> +               };
> +
> +               fimc_1: fimc at 11810000 {
> +                       compatible = "samsung,exynos4212-fimc";
> +                       clocks = <&clock 257>, <&clock 129>, <&clock 385>, <&clock 17>;
> +                       clock-names = "fimc", "sclk_fimc", "mux", "parent";
> +                       samsung,pix-limits = <4224 8192 1920 4224>;
> +                       samsung,mainscaler-ext;
> +                       samsung,isp-wb;
> +                       samsung,cam-if;
> +               };
> +
> +               fimc_2: fimc at 11820000 {
> +                       compatible = "samsung,exynos4212-fimc";
> +                       clocks = <&clock 258>, <&clock 130>, <&clock 386>, <&clock 17>;
> +                       clock-names = "fimc", "sclk_fimc", "mux", "parent";
> +                       samsung,pix-limits = <4224 8192 1920 4224>;
> +                       samsung,mainscaler-ext;
> +                       samsung,isp-wb;
> +                       samsung,lcd-wb;
> +                       samsung,cam-if;
> +               };
> +
> +               fimc_3: fimc at 11830000 {
> +                       compatible = "samsung,exynos4212-fimc";
> +                       clocks = <&clock 259>, <&clock 131>, <&clock 387>, <&clock 17>;
> +                       clock-names = "fimc", "sclk_fimc", "mux", "parent";
> +                       samsung,pix-limits = <1920 8192 1366 1920>;
> +                       samsung,rotators = <0>;
> +                       samsung,mainscaler-ext;
> +                       samsung,isp-wb;
> +                       samsung,lcd-wb;
> +               };
> +
> +               csis_0: csis at 11880000 {
> +                       clocks = <&clock 260>, <&clock 134>, <&clock 390>, <&clock 17>;
> +                       clock-names = "csis", "sclk_csis", "mux", "parent";
> +               };
> +
> +               csis_1: csis at 11890000 {
> +                       clocks = <&clock 261>, <&clock 135>, <&clock 391>, <&clock 17>;
> +                       clock-names = "csis", "sclk_csis", "mux", "parent";
> +               };
> +
> +               fimc_lite_0: fimc-lite at 12390000 {
> +                       compatible = "samsung,exynos4212-fimc-lite";
> +                       reg = <0x12390000 0x1000>;
> +                       interrupts = <0 105 0>;
> +                       samsung,power-domain = <&pd_isp>;
> +                       clocks = <&clock 353>;
> +                       clock-names = "flite";
> +                       status = "disabled";
> +               };
> +
> +               fimc_lite_1: fimc-lite at 123A0000 {
> +                       compatible = "samsung,exynos4212-fimc-lite";
> +                       reg = <0x123A0000 0x1000>;
> +                       interrupts = <0 106 0>;
> +                       samsung,power-domain = <&pd_isp>;
> +                       clocks = <&clock 354>;
> +                       clock-names = "flite";
> +                       status = "disabled";
> +               };
> +
> +               fimc_is: fimc-is at 12000000 {
> +                       compatible = "samsung,exynos4212-fimc-is", "simple-bus";
> +                       reg = <0x12000000 0x260000>;
> +                       interrupts = <0 90 0>, <0 95 0>;
> +                       samsung,power-domain = <&pd_isp>;
> +                       clocks = <&clock 353>, <&clock 354>, <&clock 355>,
> +                               <&clock 356>, <&clock 17>, <&clock 357>,
> +                               <&clock 358>, <&clock 359>, <&clock 360>,
> +                               <&clock 450>,<&clock 451>, <&clock 452>,
> +                               <&clock 453>, <&clock 176>, <&clock 13>,
> +                               <&clock 454>, <&clock 395>, <&clock 455>;
> +                       clock-names = "lite0", "lite1", "ppmuispx",
> +                                     "ppmuispmx", "mpll", "isp",
> 
> 
> I notice a tiny typo in the documentation
> 
> --- a/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
> +++ b/Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
> @@ -15,7 +15,7 @@ Required properties:
>  - interrupts   : must contain two FIMC-IS interrupts, in order: ISP0, ISP1;
>  - clocks       : list of clock specifiers, corresponding to entries in
>                   clock-names property;
> -- clock-names  : must contain "ppmuispx", "ppmuispx", "lite0", "lite1"
> +- clock-names  : must contain "ppmuispx", "ppmuispmx", "lite0", "lite1"
>                   "mpll", "sysreg", "isp", "drc", "fd", "mcuisp", "uart",
>                   "ispdiv0", "ispdiv1", "mcuispdiv0", "mcuispdiv1", "aclk200",
>                   "div_aclk200", "aclk400mcuisp", "div_aclk400mcuisp" entries,
> 
> 
> +                                     "drc", "fd", "mcuisp",
> +                                     "ispdiv0", "ispdiv1", "mcuispdiv0",
> +                                     "mcuispdiv1", "uart", "aclk200",
> +                                     "div_aclk200", "aclk400mcuisp",
> +                                     "div_aclk400mcuisp";
> 
> "sysreg" is missing from that list, but is listed as required in the documentation.

Yes, "sysreg" clock was originally intended to be included in this list,
but this clock is not really specific to the FIMC-IS subsystem so I removed
it from the driver [1]. The biding documentation needs to be updated.
Good catch, thanks.

[1]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/media/platform/exynos4-is?id=6301b13213d55e51b7255b1098618ba99d2945cd

> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       status = "disabled";
> +
> +                       pmu {
> +                               reg = <0x10020000 0x3000>;
> +                       };
> +
> +                       i2c1_isp: i2c-isp at 12140000 {
> +                               compatible = "samsung,exynos4212-i2c-isp";
> +                               reg = <0x12130000 0x100>;
> 
> Typo 1214000 vs. 12130000?

Oops, I didn't notice it during tests, since this I2C bus controller
is handled by the Cortex A5 firmware. I'll change it to 0x12140000.

> +                               clocks = <&clock 370>;
> +                               clock-names = "i2c_isp";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +               };
> +       };
>  };

Thanks,
Sylwester
