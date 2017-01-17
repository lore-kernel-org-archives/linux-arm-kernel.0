From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 16 Jan 2017 21:27:00 -0800
Subject: [PATCH v4 1/3] dt: bindings: add documentation for zx2967 family
 thermal sensor
In-Reply-To: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
References: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170117052658.GA3246@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Fri, Jan 13, 2017 at 06:46:56PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family thermal sensor.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  .../devicetree/bindings/thermal/zx2967-thermal.txt  | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> new file mode 100644
> index 0000000..86f941c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
> @@ -0,0 +1,21 @@
> +* ZTE zx2967 family Thermal
> +
> +Required Properties:
> +- compatible: should be one of the following.
> +    * zte,zx296718-thermal
> +- reg: physical base address of the controller and length of memory mapped
> +    region.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- clock-names: "gate" for the topcrm clock.
> +	       "pclk" for the apb clock.
> +- #thermal-sensor-cells: must be 0.
> +
> +Example:
> +
> +	tempsensor: tempsensor at 148a000 {
> +		compatible = "zte,zx296718-thermal";
> +		reg = <0x0148a000 0x20>;
> +		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
> +		clock-names = "gate", "pclk";
> +		#thermal-sensor-cells = <0>;
> +	};

Given that you are using of-thermal, would be welcome if you include an
example on how to deploy a thermal zone with your tempsensor entry.

> -- 
> 2.7.4
> 
