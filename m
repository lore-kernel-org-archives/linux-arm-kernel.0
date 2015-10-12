From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Oct 2015 14:44:23 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
Message-ID: <561B48B7.1040201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.10.2015 00:46, Anand Moon wrote:
> Added support for UHS-I bus speed 50MB/s (SDR50, DDR50) 104MB/s (SDR104)

This description is not entirely correct. The MMC driver already
supports these UHS speeds (you did not any code) so you rather enabled
it (description of bindings says "is supported").

You mentioned DDR50 but I don't see respective property below.

How do you know that these modes are really supported? I don't know. Can
you convince me?

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> 
> ---
> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
> 
> Changes Fixed the UHS-I bus speed detedtion on cold boot.

I don't get what is exactly fixed here. What was the error? What is the
outcome of this fix? The log below is before or after?

Best regards,
Krzysztof

> 
> [    2.439806] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 100000000Hz, actual 100000000HZ div = 0)
> [    2.449729] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
> [    2.455984] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
> [    2.461743]  mmcblk0: p1 p2

> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 58c06d3..ba4a87b 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -364,6 +364,10 @@
>  	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>  	bus-width = <4>;
>  	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
>  };
>  
>  &pinctrl_0 {
> 
