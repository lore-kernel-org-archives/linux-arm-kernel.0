From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Nov 2016 20:56:18 -0600
Subject: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
In-Reply-To: <20161118024436.13447-6-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
Message-ID: <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 08:44 PM, Robert Nelson wrote:
again.. a short commit message at least please? :)

> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Julien <jboulnois@gmail.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> index 6df7829..3bc47be 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
> @@ -97,6 +97,12 @@
>  		#cooling-cells = <2>;
>  	};
>
> +	gpu-subsystem {
A) do we want to make things clear that this is gpu subsystem for gc320?
B) How about other platforms that could equally reuse?

> +		compatible = "ti,gc320-gpu-subsystem";
> +		cores = <&bb2d>;
> +		status = "okay";
> +	};
> +
>  	hdmi0: connector {
>  		compatible = "hdmi-connector";
>  		label = "hdmi";
> @@ -190,6 +196,11 @@
>  		>;
>  	};
>  };
> +
> +&bb2d {
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <400000>;
>


-- 
Regards,
Nishanth Menon
