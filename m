From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 9 Sep 2016 16:25:03 +0200
Subject: [PATCH V4 3/4] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
In-Reply-To: <1473407397-29395-4-git-send-email-kernel@martin.sperl.org>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org>
 <1473407397-29395-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <19cc8fbf-6ceb-995e-850d-9d82bdaff8d0@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.09.2016 um 09:49 schrieb kernel at martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add the node for the thermal sensor of the bcm2835-soc
> to the device tree.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index b982522..e2e3a46 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -186,6 +186,12 @@
>  			interrupts = <2 14>; /* pwa1 */
>  		};
>  
> +		thermal: thermal at 0x7e212000 {
> +			compatible = "brcm,bcm2835-thermal";
> +			reg = <0x7e212000 0x8>;
> +			clocks = <&clocks BCM2835_CLOCK_TSENS>;
> +		};
> +

Since the driver handles 3 different SoC (2835, 2836, 2837). This node
should be defined in the SoC specific dtsi files, because the BCM2836
includes bcm283x.dtsi too.

Be aware the patch for bcm2837 must go to ARM64.

>  		aux: aux at 0x7e215000 {
>  			compatible = "brcm,bcm2835-aux";
>  			#clock-cells = <1>;
