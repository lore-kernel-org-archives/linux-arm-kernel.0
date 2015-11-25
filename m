From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Nov 2015 14:04:53 -0600
Subject: [RFC PATCH 01/10] dt-bindings: document the MPS2 timer bindings
In-Reply-To: <1448447621-17900-2-git-send-email-vladimir.murzin@arm.com>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
 <1448447621-17900-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20151125200441.GA30473@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 10:33:32AM +0000, Vladimir Murzin wrote:
> This adds documentation of device tree bindings for the
> timers found on ARM MPS2 platform.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/timer/arm,mps2-timer.txt   |   28 ++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt b/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
> new file mode 100644
> index 0000000..48f84d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
> @@ -0,0 +1,28 @@
> +ARM MPS2 timer
> +
> +The MPS2 platform has simple general-purpose 32 bits timers.
> +
> +Required properties:
> +- compatible	: Should be "arm,mps2-timer"
> +- reg		: Address and length of the register set
> +- interrupts	: Reference to the timer interrupt
> +
> +Required clocking property, have to be one of:
> +- clocks	   : The input clock of the timer
> +- clock-frequency : The rate in HZ in input of the ARM MPS2 timer
> +
> +Examples:
> +
> +timer1: mps2-timer at 40000000 {
> +	compatible = "arm,mps2-timer";
> +	reg = <0x40000000 0x1000>;
> +	interrupts = <8>;
> +	clocks = <&sysclk>;
> +};
> +
> +timer2: mps2-timer at 40001000 {
> +	compatible = "arm,mps2-timer";
> +	reg = <0x40001000 0x1000>;
> +	interrupts = <9>;
> +	clock-frequency = <25000000>;
> +};
> -- 
> 1.7.9.5
> 
