From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 11:32:43 -0500
Subject: [PATCH-V2 1/5] dt: bindings: add thermal device driver for bcm2835
In-Reply-To: <1463145186-12906-2-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
 <1463145186-12906-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160516163243.GA20435@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 01:13:02PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add documentation for bcm2835 SOC thermal sensor.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Acked-by: Eric Anholt <eric@anholt.net>
> 
> Changelog:
>  V1 -> V2: renamed file to follow naming conventions
> ---
>  .../bindings/thermal/brcm,bcm2835-thermal.txt           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
> new file mode 100644
> index 0000000..09de164
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
> @@ -0,0 +1,17 @@
> +Binding for Thermal Sensor driver for BCM2835 SoCs.
> +
> +Required parameters:
> +-------------------
> +
> +compatible: 	should be one of: "brcm,bcm2835-thermal",
> +		"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
> +reg:		Address range of the thermal registers.
> +clocks: 	Phandle of the clock used by the thermal sensor.
> +
> +Example:
> +
> +thermal: thermal at 0x7e212000 {

Drop the '0x'. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +	compatible = "brcm,bcm2835-thermal";
> +	reg = <0x7e212000 0x8>;
> +	clocks = <&clocks BCM2835_CLOCK_TSENS>;
> +};
> --
> 2.1.4
