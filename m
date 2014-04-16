From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 16 Apr 2014 21:03:54 +0200
Subject: [PATCH 1/2] ARM: berlin: add scu and chipctrl device nodes for
 BG2/BG2Q
In-Reply-To: <1395347986-30203-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1395347986-30203-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1395347986-30203-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <534ED41A.3000202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2014 09:39 PM, Sebastian Hesselbarth wrote:
> This adds scu and general purpose registers device nodes required for
> SMP on Berlin BG2 and BG2Q SoCs. The secondary CPUs will pick their jump
> address from general purpose (SW generic) register 1.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Applied to berlin/dt.

> ---
>  arch/arm/boot/dts/berlin2.dtsi  | 10 ++++++++++
>  arch/arm/boot/dts/berlin2q.dtsi | 10 ++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> index 56a1af2f1052..4d85312dc17a 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
> @@ -72,6 +72,11 @@
>  			cache-level = <2>;
>  		};
>  
> +		scu: snoop-control-unit at ad0000 {
> +			compatible = "arm,cortex-a9-scu";
> +			reg = <0xad0000 0x58>;
> +		};
> +
>  		gic: interrupt-controller at ad1000 {
>  			compatible = "arm,cortex-a9-gic";
>  			reg = <0xad1000 0x1000>, <0xad0100 0x0100>;
> @@ -176,6 +181,11 @@
>  			};
>  		};
>  
> +		generic-regs at ea0184 {
> +			compatible = "marvell,berlin-generic-regs", "syscon";
> +			reg = <0xea0184 0x10>;
> +		};
> +
>  		apb at fc0000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 07452a7483fa..86d8a2c49f38 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -87,6 +87,11 @@
>  			cache-level = <2>;
>  		};
>  
> +		scu: snoop-control-unit at ad0000 {
> +			compatible = "arm,cortex-a9-scu";
> +			reg = <0xad0000 0x58>;
> +		};
> +
>  		local-timer at ad0600 {
>  			compatible = "arm,cortex-a9-twd-timer";
>  			reg = <0xad0600 0x20>;
> @@ -183,6 +188,11 @@
>  			};
>  		};
>  
> +		generic-regs at ea0110 {
> +			compatible = "marvell,berlin-generic-regs", "syscon";
> +			reg = <0xea0110 0x10>;
> +		};
> +
>  		apb at fc0000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> 
