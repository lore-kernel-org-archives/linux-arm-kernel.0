From: lee@kernel.org (Lee Jones)
Date: Fri, 5 Jun 2015 20:24:25 +0100
Subject: [PATCH v7 3/3] ARM: bcm2835: Add the firmware driver information
 to the RPi DT
In-Reply-To: <1433448707-18104-3-git-send-email-eric@anholt.net>
References: <1433448707-18104-1-git-send-email-eric@anholt.net>
 <1433448707-18104-3-git-send-email-eric@anholt.net>
Message-ID: <20150605192425.GC3301@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 04 Jun 2015, Eric Anholt wrote:

> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Lee Jones <lee@kernel.org> (previous version with pm-domains)
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> 
> v2: Drop pm-domains stuff since I've dropped it from the firmware
>     driver for now, until we get drivers/base fixed.
> 
> v3: Rename the compatible to "raspberrypi,bcm2835-firmware"
> 
>  arch/arm/boot/dts/bcm2835-rpi.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied for v4.2, thanks.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 46780bb..ab5474e 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -14,6 +14,13 @@
>  			linux,default-trigger = "heartbeat";
>  		};
>  	};
> +
> +	soc {
> +		firmware: firmware {
> +			compatible = "raspberrypi,bcm2835-firmware";
> +			mboxes = <&mailbox>;
> +		};
> +	};
>  };
>  
>  &gpio {
