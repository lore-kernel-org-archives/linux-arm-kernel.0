From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Mar 2016 17:34:58 +0900
Subject: [PATCH 10/10] ARM: dts: Add PPMU node for exynos3250-artik5 module
In-Reply-To: <1457921056-21257-12-git-send-email-cw00.choi@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-12-git-send-email-cw00.choi@samsung.com>
Message-ID: <56E677B2.3080304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2016 11:04, Chanwoo Choi wrote:
> This patch adds PPMU (Platform Performance Monitoring Unit) Device Tree node
> for Exynos3250 based ARTIK5 module. The PPMU node is used to get the
> utilization of DMC0/DMC1/LEFTBUS/RIGHTBUS Block.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 36 ++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

What is the status with your devfreq patches? Instead of this one, there
should be just:
	#include "exynos4412-ppmu-common.dtsi"
(squashed into patch 5/10).

Best regards,
Krzysztof

> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index 673883fda480..995356708b7d 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> @@ -321,6 +321,42 @@
>  	status = "okay";
>  };
>  
> +&ppmu_dmc0 {
> +	status = "okay";
> +	events {
> +		ppmu_dmc0_3: ppmu-event3-dmc0 {
> +			event-name = "ppmu-event3-dmc0";
> +		};
> +	};
> +};
> +
> +&ppmu_dmc1 {
> +	status = "okay";
> +	events {
> +		ppmu_dmc1_3: ppmu-event3-dmc1 {
> +			event-name = "ppmu-event3-dmc1";
> +		};
> +	};
> +};
> +
> +&ppmu_leftbus {
> +	status = "okay";
> +	events {
> +		ppmu_leftbus_3: ppmu-event3-leftbus {
> +			event-name = "ppmu-event3-leftbus";
> +		};
> +	};
> +};
> +
> +&ppmu_rightbus {
> +	status = "okay";
> +	events {
> +		ppmu_rightbus_3: ppmu-event3-rightbus {
> +			event-name = "ppmu-event3-rightbus";
> +		};
> +	};
> +};
> +
>  &tmu {
>  	status = "okay";
>  };
> 
