From: antoine.tenart@free-electrons.com (=?UTF-8?B?QW50b2luZSBUw6luYXJ0?=)
Date: Fri, 21 Mar 2014 10:20:24 +0100
Subject: [PATCH 1/2] ARM: berlin: add scu and chipctrl device nodes for
 BG2/BG2Q
In-Reply-To: <1395347986-30203-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1395347986-30203-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1395347986-30203-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <532C0458.1090906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/2014 21:39, Sebastian Hesselbarth wrote:
> This adds scu and general purpose registers device nodes required for
> SMP on Berlin BG2 and BG2Q SoCs. The secondary CPUs will pick their jump
> address from general purpose (SW generic) register 1.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Antoine T?nart <antoine.tenart@free-electrons.com>

Also tested on the BG2Q,

Tested-by: Antoine T?nart <antoine.tenart@free-electrons.com>

> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   arch/arm/boot/dts/berlin2.dtsi  | 10 ++++++++++
>   arch/arm/boot/dts/berlin2q.dtsi | 10 ++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> index 56a1af2f1052..4d85312dc17a 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
> @@ -72,6 +72,11 @@
>   			cache-level = <2>;
>   		};
>
> +		scu: snoop-control-unit at ad0000 {
> +			compatible = "arm,cortex-a9-scu";
> +			reg = <0xad0000 0x58>;
> +		};
> +
>   		gic: interrupt-controller at ad1000 {
>   			compatible = "arm,cortex-a9-gic";
>   			reg = <0xad1000 0x1000>, <0xad0100 0x0100>;
> @@ -176,6 +181,11 @@
>   			};
>   		};
>
> +		generic-regs at ea0184 {
> +			compatible = "marvell,berlin-generic-regs", "syscon";
> +			reg = <0xea0184 0x10>;
> +		};
> +
>   		apb at fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 07452a7483fa..86d8a2c49f38 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -87,6 +87,11 @@
>   			cache-level = <2>;
>   		};
>
> +		scu: snoop-control-unit at ad0000 {
> +			compatible = "arm,cortex-a9-scu";
> +			reg = <0xad0000 0x58>;
> +		};
> +
>   		local-timer at ad0600 {
>   			compatible = "arm,cortex-a9-twd-timer";
>   			reg = <0xad0600 0x20>;
> @@ -183,6 +188,11 @@
>   			};
>   		};
>
> +		generic-regs at ea0110 {
> +			compatible = "marvell,berlin-generic-regs", "syscon";
> +			reg = <0xea0110 0x10>;
> +		};
> +
>   		apb at fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
>

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
