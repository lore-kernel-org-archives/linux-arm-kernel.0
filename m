From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 19:21:46 +0200
Subject: [PATCH 2/5] clk: berlin: add berlin clocks DT bindings
 documentation
In-Reply-To: <1398261667-12621-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398261667-12621-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1398261667-12621-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5357F6AA.1010406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 04:01 PM, Alexandre Belloni wrote:
> Document the newly added berlin clock driver
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: devicetree at vger.kernel.org
>  Documentation/devicetree/bindings/clock/berlin-clock.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/berlin-clock.txt b/Documentation/devicetree/bindings/clock/berlin-clock.txt
> index 49b7860bffb8..00f0053ef587 100644
> --- a/Documentation/devicetree/bindings/clock/berlin-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/berlin-clock.txt
> @@ -9,6 +9,8 @@ Required properties:
>  	"marvell,berlin2-pll",
>  	"marvell,berlin2q-pll":
>  		CPU PLL and System PLL
> +	"marvell,berlin2-clk":
> +		simple clocks
>  - reg: Address and length of the clock register set.
>  - #clock-cells: from common clock binding; shall be set to 0.
>  - clocks: from common clock binding
> @@ -26,4 +28,9 @@ cpupll: cpupll at ea003c {
>  	reg = <0xea003c 0x8>;
>  };
>  
> -
> +sdio0xinclk: sdio0xinclk at ea023c {

Yuck! ;)

Can't we just simply use "clock@<addr>" for the node name and
have the driver compute the name like simple-bus does?

Sebastian

> +	compatible = "marvell,berlin-clk";
> +	clocks = <&syspll>;
> +	#clock-cells = <0>;
> +	reg = <0xea023c 4>;
> +};
> 
