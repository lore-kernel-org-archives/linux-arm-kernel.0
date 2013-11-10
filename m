From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Nov 2013 19:12:18 +0100
Subject: [PATCHv3 1/3] ARM: dts: exynos4212: Add PMU dt data for pmu-irq
In-Reply-To: <1383530161-24080-2-git-send-email-cw00.choi@samsung.com>
References: <1383530161-24080-1-git-send-email-cw00.choi@samsung.com>
 <1383530161-24080-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <9228109.fILkd0ZUhT@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

Please add a patch description. Even if trivial, it is good to have one.

On Monday 04 of November 2013 10:55:59 Chanwoo Choi wrote:
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4212.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
> index 6f34d7f..3081bae 100644
> --- a/arch/arm/boot/dts/exynos4212.dtsi
> +++ b/arch/arm/boot/dts/exynos4212.dtsi
> @@ -56,4 +56,10 @@
>  					<0x5 0 &gic 1 12 0>;
>  		};
>  	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 2>, <3 2>;
> +	};

I believe it would be better to put this in exynos4x12.dtsi, specifying
all four interrupts for possible four cores in Exynos4412. It would be
fine, since the interrupt layout is the same on all Exynos4x12 SoCs, just
some interrupts are not used.

Best regards,
Tomasz
