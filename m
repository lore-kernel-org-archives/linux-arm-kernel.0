From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 19 Mar 2014 13:29:19 +0100
Subject: [PATCH v4 1/3] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
In-Reply-To: <1395153167-21029-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1395153167-21029-1-git-send-email-antoine.tenart@free-electrons.com>
 <1395153167-21029-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53298D9F.7060205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2014 03:32 PM, Antoine T?nart wrote:
> Adds initial support for the Marvell Armada 1500 pro (BG2Q) SoC (Berlin family).
> The SoC has nodes for cpu, l2 cache controller, interrupt controllers, local
> timer, apb timers and uarts for now.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 224 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 224 insertions(+)
>   create mode 100644 arch/arm/boot/dts/berlin2q.dtsi
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> new file mode 100644
> index 000000000000..aa90c273fdf2
> --- /dev/null
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
[...]
> +	smclk: sysmgr-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
[...]
> +		apb at fc0000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0xfc0000 0x10000>;
> +			interrupt-parent = <&sic>;
> +
> +			uart0: uart at 9000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x9000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <8>;
> +				clock-frequency = <25000000>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			uart1: uart at a000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0xa000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <9>;
> +				clock-frequency = <25000000>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};

Antoine,

I have tentatively applied this to berlin/dt with a small fixup we
discussed on IRC:

uart0/uart1 clock-frequency = <foo>; replaced by clocks = <&smclk>;

For now, as I don't have a non-github repo yet, you'll find the
branches on:

https://github.com/shesselba/linux-berlin.git

There is also a for-next branch that will become be part of linux/next
as soon as I figured out how to request it being pulled.

Sebastian
