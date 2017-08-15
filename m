From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Aug 2017 14:32:43 +0100
Subject: [PATCH 2/2] arm64: dts: hi6220: add acpu_sctrl
In-Reply-To: <1492478242-16146-2-git-send-email-zhangfei.gao@linaro.org>
References: <1492478242-16146-1-git-send-email-zhangfei.gao@linaro.org>
 <1492478242-16146-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <5992F7FB.9080709@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei,

On 2017/4/18 2:17, Zhangfei Gao wrote:
> Add acpu_sctrl clock node
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 470461d..710cc34 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -262,6 +262,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		acpu_sctrl: acpu_sctrl at f7032000 {
> +			compatible = "hisilicon,hi6220-acpu-sctrl", "syscon";
> +			reg = <0x0 0xf6504000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		medianoc_ade: medianoc_ade at f4520000 {
>  			compatible = "syscon";
>  			reg = <0x0 0xf4520000 0x0 0x4000>;
> 

Thanks!
Applied to the hisilicon dt tree since the driver part is in the mainline now.

Best Regards,
Wei
