From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 26 Apr 2014 20:23:42 +0200
Subject: [linux-sunxi] [PATCH 1/2] ARM: sun7i: Add ARM PMU in A20 DTSI
In-Reply-To: <1397847149-26501-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847149-26501-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <535BF9AE.9060904@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/18/2014 08:52 PM, Maxime Ripard wrote:
> Enable the performance monitoring unit found in the A20 SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Both patches look good and are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 899fd0e2b749..cc0d37fe5ae1 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -57,6 +57,12 @@
>  			     <1 10 0xf08>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> +		interrupts = <0 120 4>,
> +			     <0 121 4>;
> +	};
> +
>  	clocks {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> 
