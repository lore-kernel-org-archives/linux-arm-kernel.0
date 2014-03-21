From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 21 Mar 2014 22:36:31 +0100
Subject: [PATCH v2 5/5] ARM: berlin/dt: add cpupll and syspll support
 to BG2
In-Reply-To: <1395432521-11055-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395432521-11055-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395432521-11055-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <532CB0DF.3080003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 09:08 PM, Alexandre Belloni wrote:
> The Berlin BG2 has two supported PLLs: CPU PLL and System PLL, add those to the
> SoC device tree.
>
> This also moves the remaining clocks from the clocks container node to the root.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2.dtsi | 48 +++++++++++++++++++++++++++---------------
>   1 file changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> index 56a1af2f1052..6c080eb6242a 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
[...]
> @@ -83,7 +83,21 @@
>   			compatible = "arm,cortex-a9-twd-timer";
>   			reg = <0xad0600 0x20>;
>   			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&sysclk>;
> +			clocks = <&twdclk>;
> +		};
> +
> +		syspll: syspll at ea0014 {
> +			compatible = "marvell,berlin2-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xea0014 8>;
> +		};
> +
> +		cpupll: cpupll at ea003c {
> +			compatible = "marvell,berlin2-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xea003c 8>;

Same comment about hex numbers and I'll also fix it up.

Sebastian

>   		};
>
>   		apb at e80000 {
>
