From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Mar 2014 11:53:18 +0000
Subject: [PATCH 2/5] clk: berlin: add berlin clocks DT bindings
 documentation
In-Reply-To: <1395402220-23503-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395402220-23503-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140321115318.GP23372@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 11:43:37AM +0000, Alexandre Belloni wrote:
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/berlin-clock.txt     | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/berlin-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/berlin-clock.txt b/Documentation/devicetree/bindings/clock/berlin-clock.txt
> new file mode 100644
> index 000000000000..ebc78f9b93a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/berlin-clock.txt
> @@ -0,0 +1,29 @@
> +Device Tree Clock bindings for Marvell Berlin clocks
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one of the following:
> +	"marvell,berlin2-pll" or
> +	"marvell,berlin2q-pll":
> +		CPU PLL and System PLL
> +- reg : Address and length of the clock register set.
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clocks : shall be the input parent clock phandle for the clock.

Nit: clocks aren't just phandles. Either define the full type (phandle +
clock-specifier pair), or don't define the type at all given it's a
standard property.

Otherwise this looks fine to me.

Cheers,
Mark.

> +
> +smclk: sysmgr-clock {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <25000000>;
> +};
> +
> +cpupll: cpupll {
> +	compatible = "marvell,berlin2-pll";
> +	clocks = <&smclk>;
> +	#clock-cells = <0>;
> +	reg = <0xf7ea003c 8>;
> +};
> +
> +
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
