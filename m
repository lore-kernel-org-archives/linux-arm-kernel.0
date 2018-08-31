From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 11:14:05 +0200
Subject: [PATCH v3 25/30] ARM: dts: sun8i: h3: add thermal zone to H3
In-Reply-To: <20180830154518.29507-26-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-26-embed3d@gmail.com>
Message-ID: <20180831091405.qr5daepgmx3otq7m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:45:13PM +0200, Philipp Rossak wrote:
> This patch adds the thermal zones to the H3. We have only one sensor and
> that is placed in the cpu.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi    | 31 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 5b7994cb1471..954848d5df50 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -78,6 +78,8 @@
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			#cooling-cells = <2>;
> +			cooling-min-level = <0>;
> +			cooling-max-level = <15>;
>  		};
>  
>  		cpu at 1 {
> @@ -102,6 +104,35 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal {
> +			/* milliseconds */
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths>;
> +
> +			trips {
> +				cpu_hot_trip: cpu-warm {
> +					temperature = <65000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_very_hot_trip: cpu-very-hot {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};

Where are those trip points coming from?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/8d9a39ee/attachment.sig>
