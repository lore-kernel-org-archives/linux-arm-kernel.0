From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 16:24:34 -0700
Subject: [PATCH 3/4] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
In-Reply-To: <1463063738-11506-4-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
 <1463063738-11506-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <87posqamh9.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add the node for the thermal sensor of the bcm2835-soc
> to the device tree.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 9db9d97..525f1f2 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -159,6 +159,12 @@
>  			status = "disabled";
>  		};
>  
> +		thermal: thermal at 0x7e212000 {
> +			compatible = "brcm,bcm2835-thermal";
> +			reg = <0x7e212000 0x8>;
> +			clocks = <&clocks BCM2835_CLOCK_TSENS>;
> +		};
> +

You could drop the "thermal: " here since nothing refers to it.  Either
way,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/05f0c6a6/attachment.sig>
