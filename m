From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Dec 2016 15:41:37 -0600
Subject: [PATCH 1/3] dt: pwm: lpc32xx: add description of clocks and
 #pwm-cells properties
In-Reply-To: <20161205014237.1689-2-vz@mleia.com>
References: <20161205014237.1689-1-vz@mleia.com>
 <20161205014237.1689-2-vz@mleia.com>
Message-ID: <20161209214137.2hdugl5rmnwjrus4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 03:42:37AM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> output each, in this case there is no need to specify PWM channel argument
> on client side, one cell for setting PWM output frequency is sufficient.
> 
> Another added to the description property 'clocks' has a standard meaning
> of a controller supply clock, in the LPC32xx User's Manual the clock is
> denoted as PWM1_CLK or PWM2_CLK clock.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> index 74b5bc5..523d796 100644
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> @@ -3,15 +3,22 @@ LPC32XX PWM controller
>  Required properties:
>  - compatible: should be "nxp,lpc3220-pwm"
>  - reg: physical base address and length of the controller's registers
> +- clocks: clock phandle and clock specifier pair
> +- #pwm-cells: should be 1, the cell is used to specify the period in
> +  nanoseconds.

This use of the cell is a bit odd as the period is s/w config and this 
would typically be a channel selection or such.

What if I want user specified/changed periods?

Rob
