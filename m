From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Wed, 12 Sep 2018 18:47:35 +0800
Subject: [PATCH 02/11] dts: hisilicon: Update coresight bindings for
 hardware ports
In-Reply-To: <1536661032-30481-3-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180912104735.GC3353@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 11:17:03AM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports.

As Shawn suggested, please change subject as "arm64: dts: hi6220:
...."

> Cc: xuwei5 at hisilicon.com
> Cc: lipengcheng8 at huawei.com
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 147 ++++++++++++---------
>  1 file changed, 85 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> index 7afee5d..2202816 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi

[...]

> @@ -302,10 +315,12 @@
>  
>  			cpu = <&cpu3>;
>  
> -			port {
> -				etm3_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in3>;
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in3>;
> +					};
>  				};
>  			};
>  		};
> @@ -319,10 +334,12 @@
>  
>  			cpu = <&cpu4>;
>  
> -			port {
> +			out-ports {
> +				port {
>  				etm4_out: endpoint {

Indent?

After applied this patch and tested on Hikey board; FWIW:

Tested-by: Leo Yan <leo.yan@linaro.org>

> -					remote-endpoint =
> -						<&acpu_funnel_in4>;
> +						remote-endpoint =
> +							<&acpu_funnel_in4>;
> +					};
>  				};
>  			};
>  		};
> @@ -336,10 +353,12 @@
>  
>  			cpu = <&cpu5>;
>  
> -			port {
> -				etm5_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in5>;
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in5>;
> +					};
>  				};
>  			};
>  		};
> @@ -353,10 +372,12 @@
>  
>  			cpu = <&cpu6>;
>  
> -			port {
> -				etm6_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in6>;
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in6>;
> +					};
>  				};
>  			};
>  		};
> @@ -370,10 +391,12 @@
>  
>  			cpu = <&cpu7>;
>  
> -			port {
> -				etm7_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in7>;
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in7>;
> +					};
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
