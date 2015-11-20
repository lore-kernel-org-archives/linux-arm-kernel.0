From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Fri, 20 Nov 2015 13:51:30 +0530
Subject: [PATCH] ARM: dts: vfxxx: Fix erroneous property in esdhc0 node
In-Reply-To: <4f43a337677572fbf2b2c8e27152db426e024f7a.1445146992.git.maitysanchayan@gmail.com>
References: <4f43a337677572fbf2b2c8e27152db426e024f7a.1445146992.git.maitysanchayan@gmail.com>
Message-ID: <20151120082130.GA5062@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On 15-10-18 11:18:48, Sanchayan Maity wrote:
> Something seems to have gone wrong during the merging of the device
> tree changes with the following patch
> 
> "ARM: dts: add property for maximum ADC clock frequencies"
> 
> The property "fsl,adck-max-frequency" instead of being applied for
> the ADC1 node got applied to the esdhc0 node. This patch fixes it.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 6736bae..a64bfe1 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -461,6 +461,8 @@
>  				clock-names = "adc";
>  				#io-channel-cells = <1>;
>  				status = "disabled";
> +				fsl,adck-max-frequency = <30000000>, <40000000>,
> +							<20000000>;
>  			};
>  
>  			esdhc0: esdhc at 400b1000 {
> @@ -472,8 +474,6 @@
>  					<&clks VF610_CLK_ESDHC0>;
>  				clock-names = "ipg", "ahb", "per";
>  				status = "disabled";
> -				fsl,adck-max-frequency = <30000000>, <40000000>,
> -							<20000000>;
>  			};
>  
>  			esdhc1: esdhc at 400b2000 {
> -- 
> 2.6.1
> 
