From: lee@kernel.org (Lee Jones)
Date: Fri, 24 Jul 2015 16:23:17 +0100
Subject: [PATCH v4 3/8] ARM: bcm2835: Add DT for the firmware clocks
 driver.
In-Reply-To: <1437420787-32137-4-git-send-email-eric@anholt.net>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
 <1437420787-32137-4-git-send-email-eric@anholt.net>
Message-ID: <20150724152317.GO3436@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jul 2015, Eric Anholt wrote:

> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> 
> v2: Rename our compat string to mention bcm2835, and make our firmware
>     phandle be under a vendor-namespaced property.
> 
>  arch/arm/boot/dts/bcm2835-rpi.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

For my own reference:
 Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index ab5474e..7cc47fb 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -20,6 +20,12 @@
>  			compatible = "raspberrypi,bcm2835-firmware";
>  			mboxes = <&mailbox>;
>  		};
> +
> +		firmware_clocks: firmware-clocks {
> +			compatible = "raspberrypi,bcm2835-firmware-clocks";
> +			#clock-cells = <1>;
> +			raspberrypi,firmware = <&firmware>;
> +		};
>  	};
>  };
>  
