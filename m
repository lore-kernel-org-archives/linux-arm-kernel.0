From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 07 Feb 2015 15:56:25 +0300
Subject: [PATCH v3 2/5] ARM: dts: pxa: add clocks
In-Reply-To: <1423312760-15871-2-git-send-email-robert.jarzmik@free.fr>
References: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
 <1423312760-15871-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <54D60B79.5060206@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/7/2015 3:39 PM, Robert Jarzmik wrote:

> Add clocks to the IPs already described in the pxa device-tree
> files. There are more clocks in the clock tree than IPs described in the
> current pxa device-tree.

> This patch ensures that :
>   - the current description is correct
>   - the clocks are actually claimed, so that clock framework doesn't
>     disable them automatically (unused clocks shutdown)

> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>   arch/arm/boot/dts/pxa27x.dtsi | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> index 98b560e..e8d5097 100644
> --- a/arch/arm/boot/dts/pxa27x.dtsi
> +++ b/arch/arm/boot/dts/pxa27x.dtsi
[...]
> @@ -12,36 +12,62 @@
>   			marvell,intc-nr-irqs = <34>;
>   		};
>
> +		gpio: gpio at 40e00000 {
> +			compatible = "intel,pxa27x-gpio";
> +			clocks = <&pxa2xx_clks CLK_NONE>;
> +		};
> +
> +		ffuart: uart at 40100000 {
> +			clocks = <&pxa2xx_clks CLK_FFUART>;
> +		};
> +
> +		btuart: uart at 40200000 {
> +			clocks = <&pxa2xx_clks CLK_BTUART>;
> +		};
> +
> +		stuart: uart at 40700000 {
> +			clocks = <&pxa2xx_clks CLK_STUART>;
> +		};
> +

    The ePAPR standard tells to call such nodes "serial", not "uart".

[...]

WBR, Sergei
