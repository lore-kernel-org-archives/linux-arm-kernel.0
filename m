From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 16:03:23 -0700
Subject: [PATCH 1/4] dt: bindings: add thermal device driver for bcm2835
In-Reply-To: <1463063738-11506-2-git-send-email-kernel@martin.sperl.org>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
 <1463063738-11506-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <87wpmyangk.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add documentation for bcm2835 SOC thermal sensor.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  .../devicetree/bindings/thermal/bcm2835-thermal.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt
> new file mode 100644
> index 0000000..607519a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt

There's a naming convention for the BCM DT bindings these days where you
basically name it after the compatible string, so this file should be
moved to "brcm,bcm2835-thermal.txt" (yes, even though it's inconsistent
with the rest of the files in the directory).

> @@ -0,0 +1,16 @@
> +Binding for Thermal Sensor driver for BCM2835 SoCs.
> +
> +Required parameters:
> +-------------------
> +
> +compatible : 	should be: "brcm,bcm2835-thermal"

Optional: change to 'should be: "brcm,bcm2835-thermal" or
"brcm,bcm2837-thermal"' (see next review for explanation).

I would also drop the space before the colons on the parameters, but as
long as the filename is changed this patch is:

Acked-by: Eric Anholt <eric@anholt.net>

> +reg :		Address range of the thermal registers.
> +clocks : 	Phandle of the clock used by the thermal sensor.
> +
> +Example:
> +
> +thermal: thermal at 0x7e212000 {
> +	compatible = "brcm,bcm2835-thermal";
> +	reg = <0x7e212000 0x8>;
> +	clocks = <&clocks BCM2835_CLOCK_TSENS>;
> +};
> -- 
> 2.1.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/f512b792/attachment.sig>
