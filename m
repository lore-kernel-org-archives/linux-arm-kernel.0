From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Mar 2015 19:54:39 +0100
Subject: [PATCH v2 6/7] ARM: mvebu: Enable Performance Monitor Unit on
 Armada 380/385 SoC
In-Reply-To: <1425379400-4346-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
 <1425379400-4346-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F6036F.4020608@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 03/03/2015 11:43, Maxime Ripard wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> The Armada 380 and 385 SoCs have a Cortex-A9 CPU, so the PMU is available
> to be used. This commit enables it in the devicetree.

This patch (and the previous one) had been intensively discussed in the first
series sent by Ezequiel. So:


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 885fcee6580c..7cd95801d844 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -64,6 +64,11 @@
>  		ethernet2 = &eth2;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupts-extended = <&mpic 3>;
> +	};
> +
>  	soc {
>  		compatible = "marvell,armada380-mbus", "simple-bus";
>  		#address-cells = <2>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
