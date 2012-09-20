From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Sep 2012 17:03:11 +0900
Subject: [PATCH 1/3] ARM: EXYNOS5: Add fimd node to the exynos5250 dtsi
 file
In-Reply-To: <1347992531-27279-2-git-send-email-l.krishna@samsung.com>
References: <1347992531-27279-1-git-send-email-l.krishna@samsung.com>
 <1347992531-27279-2-git-send-email-l.krishna@samsung.com>
Message-ID: <008201cd9706$60e7e2e0$22b7a8a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 19, 2012 3:22 AM Leela Krishna Amudala wrote
> 
> This patch adds the fimd node with compatibility string, hardware address,
> interrupt line numbers to the exynos5250 dtsi file.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index b55794b..6d27ca4 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -488,4 +488,11 @@
>  		reg = <0x13e30000 0x1000>;
>  		interrupts = <0 88 0>;
>  	};
> +
> +	fimd {
> +		compatible = "samsung,exynos5-drm";

Should it be "samsung,exynos5-fimd"?


> +		interrupt-parent = <&combiner>;
> +		reg = <0x14400000 0x40000>;
> +		interrupts = <18 5>, <18 4>, <18 6>;
> +	};
>  };
> --
> 1.7.0.4
