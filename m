From: david@lechnology.com (David Lechner)
Date: Tue, 23 Jan 2018 22:08:26 -0600
Subject: [PATCH v6 41/41] ARM: dts: da850: Add clocks
In-Reply-To: <1516468460-4908-42-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-42-git-send-email-david@lechnology.com>
Message-ID: <5f394e07-4384-6f0d-806e-a692da3b780a@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2018 11:14 AM, David Lechner wrote:
> This adds clock provider nodes for da850 and wires them up to all of the
> devices.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v6 changes:
> - updated for device tree bindings changes earlier in this series
> - use single async2 clock instead of duplicate fixed factor clocks
> - add clock-names property to mdio node
> 
>   arch/arm/boot/dts/da850.dtsi | 162 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi

...

> +		psc1: clock-controller at 227000 {
> +			compatible = "ti,da850-psc1";
> +			reg = <0x227000 0x1000>;
> +			#clock-cells = <1>;
> +			clocks = <&pll0_sysclk 2>, <&pll0_sysclk 4>,
> +				 <&async3_clk>;
> +			clock_names = "pll0_sysclk2", "pll0_sysclk4", "async3";

Should be clock-names, not clock_names

>   		};
