From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Sep 2016 17:22:54 -0700
Subject: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain
 to exynos4x12 clocks device
In-Reply-To: <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20160908002254.GD13062@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01, Marek Szyprowski wrote:
> Exynos4412 clock controller contains some additional clocks for FIMC-ISP
> (Camera ISP) subsystem. Registers for those clocks are partially located
> in the SOC area, which belongs to ISP power domain.
> 
> This patch extends clock controller node with ISP clock sub-node and link
> (phandle) to ISP power domain.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 3394bdcf10ae..4daea67546b9 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -74,6 +74,11 @@
>  		compatible = "samsung,exynos4412-clock";
>  		reg = <0x10030000 0x20000>;
>  		#clock-cells = <1>;
> +
> +		isp-clock-controller {
> +			compatible = "samsung,exynos4412-isp-clock";
> +			power-domains = <&pd_isp>;
> +		};

Why can't we extend support in power domains code to have
multiple domains for a single device node? i.e. power-domains =
<&pd_isp>, <&pd_foo>, <&pd_bar>, and then pick the right one with
power-domain-names or something like that? Making a subnode
(which seems to turn into a child platform device?) seems like a
quick solution for larger problems.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
