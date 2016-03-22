From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Tue, 22 Mar 2016 20:25:13 +0100
Subject: [PATCH 2/2] ARM: dts: exynos: Enable SSS on Trats2
In-Reply-To: <1458612003-30284-2-git-send-email-k.kozlowski@samsung.com>
References: <1458612003-30284-1-git-send-email-k.kozlowski@samsung.com>
 <1458612003-30284-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56F19C19.50207@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

you can also add the node to the exynos4412-odroid-common dtsi. I have
checked that it works properly on an X2.

Thanks for patches and fixing that alignment issue!

With best wishes,
Tobias



Krzysztof Kozlowski wrote:
> Enable the Security SubSystem (SSS) on Trats2 (Exynos4412) board which
> allows usage of its hardware accelerated AES operations.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index ed017cc7b14f..2bf363c3bf62 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -1286,6 +1286,10 @@
>  	};
>  };
>  
> +&sss {
> +	status = "okay";
> +};
> +
>  &tmu {
>  	vtmu-supply = <&ldo10_reg>;
>  	status = "okay";
> 
