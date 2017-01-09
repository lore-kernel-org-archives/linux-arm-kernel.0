From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Jan 2017 10:41:37 +0800
Subject: [PATCH v1 1/3] dt: bindings: add thermal device driver for zx2967
In-Reply-To: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
References: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170109024136.GJ20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 01:38:06PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family thermal sensor.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

The patch subject is inappropriate.  The patch adds a bindings not
device driver.

> ---
>  .../devicetree/bindings/thermal/zx2967-thermal.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> new file mode 100644
> index 0000000..2633964
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> @@ -0,0 +1,22 @@
> +* ZTE zx2967 family Thermal
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx2967-thermal
> +    * zte,zx296718-thermal

We usually use specific SoC name in compatible string to specify the
programming model for the hardware.  That said, I do not think we need
"zte,zx2967-thermal".

> +- reg: physical base address of the controller and length of memory mapped
> +    region.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- clock-names: "tempsensor_gate" for the topcrm clock.
> +	       "tempsensor_pclk" for the apb clock.

In the context of tempsensor device, the "tempsensor_" in the clock
names are not really necessary.

> +- #thermal-sensor-cells: must be 0.
> +
> +Example:
> +
> +	tempsensor: tempsensor at 148a000 {
> +		compatible = "zte,zx2967-thermal";

"zte,zx296718-thermal"

Shawn

> +		reg = <0x0148a000 0x20>;
> +		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
> +		clock-names = "tempsensor_gate", "tempsensor_pclk";
> +		#thermal-sensor-cells = <0>;
> +	};
> -- 
> 2.7.4
> 
