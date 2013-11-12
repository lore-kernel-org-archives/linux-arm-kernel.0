From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 12 Nov 2013 16:29:53 +0100
Subject: [PATCH 1/7] arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
In-Reply-To: <1383945677-29674-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383945677-29674-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <52824971.5060203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 10:21 PM, Soren Brinkmann wrote:
> The bindings for the TTC changed in commit 'arm: zynq: Use standard
> timer binding' (e932900a3279b5dbb6d8f43c7b369003620e137c). That change
> removed possible subnodes from this driver rendering the 'clock-ranges'
> property invalid for this node.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/boot/dts/zynq-7000.dtsi | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index e32b92b949d2..27ebc1ba9671 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -98,7 +98,6 @@
>   			compatible = "cdns,ttc";
>   			clocks = <&clkc 6>;
>   			reg = <0xF8001000 0x1000>;
> -			clock-ranges;
>   		};
>
>   		ttc1: ttc1 at f8002000 {
> @@ -107,7 +106,6 @@
>   			compatible = "cdns,ttc";
>   			clocks = <&clkc 6>;
>   			reg = <0xF8002000 0x1000>;
> -			clock-ranges;
>   		};
>   		scutimer: scutimer at f8f00600 {
>   			interrupt-parent = <&intc>;
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
