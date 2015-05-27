From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 May 2015 21:02:23 +0900
Subject: [PATCH 3/5] ARM: EXYNOS: DTS: add SROM device node for exynos4
In-Reply-To: <1430296712-10287-4-git-send-email-pankaj.dubey@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
 <1430296712-10287-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5565B24F.9060601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 29.04.2015 o 17:38, Pankaj Dubey pisze:
> Add SROM device node for exynos4.

Subject prefix: "ARM: dts:"

> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 77ea547..48490ea 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -76,6 +76,11 @@
>  		reg = <0x10000000 0x100>;
>  	};
>  
> +	sromc at 12570000 {
> +		compatible = "samsung,exynos-srom";
> +		reg = <0x12570000 0x100>;

There are 5 registers, so size of 0x100 seems to be bigger than needed.
Maybe limit it to actual length?

Best regards,
Krzysztof
