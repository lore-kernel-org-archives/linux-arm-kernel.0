From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Mar 2017 10:54:15 +0800
Subject: [PATCH v5 5/8] dt-bindings: input: touchscreen: Add max11801-ts
 binding
In-Reply-To: <1489484897-14933-6-git-send-email-jagan@openedev.com>
References: <1489484897-14933-1-git-send-email-jagan@openedev.com>
 <1489484897-14933-6-git-send-email-jagan@openedev.com>
Message-ID: <20170316025413.GV3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 03:18:14PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Add missing documentation of max11801-ts dt-binding details.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v5:
> - Newly added patch
> 
>  .../bindings/input/touchscreen/max11801-ts.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
> new file mode 100644
> index 0000000..b6ac452
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
> @@ -0,0 +1,18 @@
> +* MAXI MAX11801 Resistive touch screen controller with i2c interface
> +
> +Required properties:
> +- compatible: must be "max11801"
> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +
> +Example:
> +
> +&i2c1 {
> +	ts: max11801 at 48 {

Node name should be generic while label can be specific.  That said, the
following form might be better choice.

	max11801: touchscreen at 48 {

Shawn

> +		compatible = "max11801";
> +		reg = <0x48>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <31 2>;
> +	};
> +};
> -- 
> 1.9.1
> 
