From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 18:02:48 -0800
Subject: [GIT PULL 2/2] ARM: dts: exynos: Topic dts for v4.10
In-Reply-To: <1479473075-9787-2-git-send-email-krzk@kernel.org>
References: <1479473075-9787-1-git-send-email-krzk@kernel.org>
 <1479473075-9787-2-git-send-email-krzk@kernel.org>
Message-ID: <20161119020248.GJ2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 02:44:35PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Topic branch with a GIC interrupt fixes and cleanup (human-friendly symbols).
> 
> Possible rather trivial conflicts:
> 
> diff --cc arch/arm/boot/dts/exynos4x12.dtsi
> index 0074f566cd3b,505f047e81c6..85a7122658f1
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@@ -147,9 -147,10 +147,10 @@@
>                 };
>   
>                 fimc_is: fimc-is at 12000000 {
>  -                      compatible = "samsung,exynos4212-fimc-is", "simple-bus";
>  +                      compatible = "samsung,exynos4212-fimc-is";
>                         reg = <0x12000000 0x260000>;
> -                       interrupts = <0 90 0>, <0 95 0>;
> +                       interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>                         power-domains = <&pd_isp>;
>                         clocks = <&clock CLK_FIMC_LITE0>,
>                                  <&clock CLK_FIMC_LITE1>, <&clock CLK_PPMUISPX>,
> 
> diff --cc arch/arm/boot/dts/exynos5410.dtsi
> index 9a91685d8890,2501249d97aa..bb90bbdbe2d9
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@@ -190,58 -181,8 +190,58 @@@
>                 pinctrl_3: pinctrl at 03860000 {
>                         compatible = "samsung,exynos5410-pinctrl";
>                         reg = <0x03860000 0x1000>;
> -                       interrupts = <0 47 0>;
> +                       interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>  +
>  +              amba {
>  +                      #address-cells = <1>;
>  +                      #size-cells = <1>;
>  +                      compatible = "simple-bus";
>  +                      interrupt-parent = <&gic>;
>  +                      ranges;
> 
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-gic-flags-4.10
> 
> for you to fetch changes up to 04a886727ca7e841afa2fbc5d87aff81ae256dbf:
> 
>   ARM: dts: exynos: Use human-friendly symbols for interrupt properties in exynos5440 (2016-11-03 22:44:56 +0200)
> 
> ----------------------------------------------------------------
> Topic branch with DT changes for v4.10.
> 
> Fix invalid GIC interrupt flags - type IRQ_TYPE_NONE is not allowed for GIC
> interrupts.  Although this was working but with error messages like:
> 	genirq: Setting trigger mode 0 for irq 16 failed
> 
> Use level high interrupt instead of type none.  The choice of level high was
> rather an arbitrary decision hoping it will work on each platform.  Tests shown
> no issues so far.

Merged, thanks. FYI, you could have based this on the previous DT branch
if you wanted to not expose the conflicts, but simple ones like these
(in particular that we can resolve in our own tree) are OK to expose too.


-Olof
