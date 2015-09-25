From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 25 Sep 2015 13:46:25 +0800
Subject: [PATCH v4 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <1443109140-5406-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443109140-5406-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1443159985.23134.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-24 at 23:38 +0800, Yingjoe Chen wrote:
> Add arch timer node to enable arch-timer support. MT8135 firmware
> doesn't correctly setup arch-timer frequency and CNTVOFF, add
> properties to workaround this.
> 
> This also set cpu enable-method to enable SMP.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index 08371db..c3c90f2 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -46,6 +46,7 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		enable-method = "mediatek,mt81xx-tz-smp";
>  
>  		cpu0: cpu at 0 {
>  			device_type = "cpu";
> @@ -72,6 +73,17 @@
>  		};
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		trustzone-bootinfo: trustzone-bootinfo at 80002000 {


Sorry, this should be

+		trustzone-bootinfo at 80002000 {

I'll fix this in next version.

Joe.C
