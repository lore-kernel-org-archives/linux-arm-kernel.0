From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 3 Apr 2017 09:08:28 +0200
Subject: [PATCH 3/3] ARM: dts: alpine: add valid clock-frequency values
In-Reply-To: <20170329093827.18881-3-antoine.tenart@free-electrons.com>
References: <20170329093827.18881-1-antoine.tenart@free-electrons.com>
 <20170329093827.18881-3-antoine.tenart@free-electrons.com>
Message-ID: <20170403070828.27sg6nxsttgzchot@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:38:27AM +0200, Antoine Tenart wrote:
> Update the Alpine clock-frequency values with valid default values. The
> bootloader can still update these values if needed, but at least we can
> boot if it does not.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on alpine/dt.
Thanks!

> ---
>  arch/arm/boot/dts/alpine.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
> index d84bd7955b54..731df7a8c4e6 100644
> --- a/arch/arm/boot/dts/alpine.dtsi
> +++ b/arch/arm/boot/dts/alpine.dtsi
> @@ -41,28 +41,28 @@
>  			compatible = "arm,cortex-a15";
>  			device_type = "cpu";
>  			reg = <0>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <1700000000>;
>  		};
>  
>  		cpu at 1 {
>  			compatible = "arm,cortex-a15";
>  			device_type = "cpu";
>  			reg = <1>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <1700000000>;
>  		};
>  
>  		cpu at 2 {
>  			compatible = "arm,cortex-a15";
>  			device_type = "cpu";
>  			reg = <2>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <1700000000>;
>  		};
>  
>  		cpu at 3 {
>  			compatible = "arm,cortex-a15";
>  			device_type = "cpu";
>  			reg = <3>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <1700000000>;
>  		};
>  	};
>  
> @@ -81,7 +81,7 @@
>  				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>  				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>  				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <50000000>;
>  		};
>  
>  		/* Interrupt Controller */
> @@ -123,7 +123,7 @@
>  		uart0: uart at fd883000 {
>  			compatible = "ns16550a";
>  			reg = <0x0 0xfd883000 0x0 0x1000>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <375000000>;
>  			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> @@ -132,7 +132,7 @@
>  		uart1: uart at fd884000 {
>  			compatible = "ns16550a";
>  			reg = <0x0 0xfd884000 0x0 0x1000>;
> -			clock-frequency = <0>; /* Filled by loader */
> +			clock-frequency = <375000000>;
>  			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
> -- 
> 2.11.0
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/c7a19edc/attachment.sig>
