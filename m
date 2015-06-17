From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Jun 2015 16:28:22 +0200
Subject: [PATCH] ARM: mvebu: use DT properties to fine-tune the L2
 configuration
In-Reply-To: <1434023472-19851-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434023472-19851-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <55818406.3070703@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 11/06/2015 13:51, Thomas Petazzoni wrote:
> In order to optimize the L2 cache performance, this commit adjusts the
> configuration of the L2 on the Cortex-A9 based Marvell EBU processors
> (Armada 375, 38x and 39x), using the appropriate DT properties.
> 
> We enable double linefill, incr double linefill, data prefetch and
> disable double linefill on wrap. This matches the configuration that
> was fine tuned in the Marvell BSP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


applied on mvebu/dt-4.3

Thanks,

Gregory

> ---
> Enabling the data prefetching depends on a patch from "Hauke Mehrtens
> <hauke@hauke-m.de>", [PATCH v4] ARM: l2c: add options to overwrite
> prefetching behavior, which has been applied by Russell (see
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8391/1)
> but does not appear yet in his for-next branch.
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 4 ++++
>  arch/arm/boot/dts/armada-38x.dtsi | 4 ++++
>  arch/arm/boot/dts/armada-39x.dtsi | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index f076ff8..4d4964b 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -176,6 +176,10 @@
>  				reg = <0x8000 0x1000>;
>  				cache-unified;
>  				cache-level = <2>;
> +				arm,double-linefill-incr = <1>;
> +				arm,double-linefill-wrap = <0>;
> +				arm,double-linefill = <1>;
> +				prefetch-data = <1>;
>  			};
>  
>  			scu at c000 {
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 218a2ac..a86d1dc 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -143,6 +143,10 @@
>  				reg = <0x8000 0x1000>;
>  				cache-unified;
>  				cache-level = <2>;
> +				arm,double-linefill-incr = <1>;
> +				arm,double-linefill-wrap = <0>;
> +				arm,double-linefill = <1>;
> +				prefetch-data = <1>;
>  			};
>  
>  			scu at c000 {
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index ecd1318..06d9cc5 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -104,6 +104,10 @@
>  				reg = <0x8000 0x1000>;
>  				cache-unified;
>  				cache-level = <2>;
> +				arm,double-linefill-incr = <1>;
> +				arm,double-linefill-wrap = <0>;
> +				arm,double-linefill = <1>;
> +				prefetch-data = <1>;
>  			};
>  
>  			scu at c000 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
