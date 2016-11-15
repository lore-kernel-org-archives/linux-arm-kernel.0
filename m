From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Nov 2016 16:13:40 +0000
Subject: [PATCH] arm64: dts: hip06: Fix no reg property warning
In-Reply-To: <1477280428-30558-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1474708465-38958-2-git-send-email-wangkefeng.wang@huawei.com>
 <1477280428-30558-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <582B3434.5090604@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 2016/10/24 4:40, Kefeng Wang wrote:
> Warning (unit_address_vs_reg): Node /soc/ethernet at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/ethernet at 5 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/ethernet at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /soc/ethernet at 1 has a unit name, but no reg property
> 
> Fix warning when build with W=1.
> 
> Cc: Kejian Yan <yankejian@huawei.com>
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

>  arch/arm64/boot/dts/hisilicon/hip06.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> index b548763..f66c51b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
> @@ -508,7 +508,7 @@
>  			};
>  		};
>  
> -		eth0: ethernet at 4{
> +		eth0: ethernet-4{
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <4>;
> @@ -517,7 +517,7 @@
>  			dma-coherent;
>  		};
>  
> -		eth1: ethernet at 5{
> +		eth1: ethernet-5{
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <5>;
> @@ -526,7 +526,7 @@
>  			dma-coherent;
>  		};
>  
> -		eth2: ethernet at 0{
> +		eth2: ethernet-0{
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <0>;
> @@ -535,7 +535,7 @@
>  			dma-coherent;
>  		};
>  
> -		eth3: ethernet at 1{
> +		eth3: ethernet-1{
>  			compatible = "hisilicon,hns-nic-v2";
>  			ae-handle = <&dsaf0>;
>  			port-idx-in-ae = <1>;
> 
