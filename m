From: robherring2@gmail.com (Rob Herring)
Date: Fri, 3 Apr 2015 12:09:16 -0500
Subject: [PATCH v5 03/15] dt-bindings: Document the ARM System timer
 bindings
In-Reply-To: <1428080481-18591-4-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428080481-18591-4-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CAL_JsqJUG4gh7nqVukfFU-kkF=QBbsinF6e+Bh35WDLRbj84qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 3, 2015 at 12:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> This adds documentation of device tree bindings for the
> ARM System timer.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/arm/armv7m_systick.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/armv7m_systick.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/armv7m_systick.txt b/Documentation/devicetree/bindings/arm/armv7m_systick.txt
> new file mode 100644
> index 0000000..7cf4a24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/armv7m_systick.txt
> @@ -0,0 +1,26 @@
> +* ARMv7M System Timer
> +
> +ARMv7-M includes a system timer, known as SysTick. Current driver only
> +implements the clocksource feature.
> +
> +Required properties:
> +- compatible     : Should be "arm,armv7m-systick"
> +- reg            : The address range of the timer
> +
> +Required clocking property, have to be one of:
> +- clocks         : The input clock of the timer
> +- clock-frequency : The rate in HZ in input of the ARM SysTick
> +
> +Examples:
> +
> +systick: timer at e000e010 {
> +       compatible = "arm,armv7m-systick";
> +       reg = <0xe000e010 0x10>;
> +       clocks = <&clk_systick>;
> +};
> +
> +systick: timer at e000e010 {
> +       compatible = "arm,armv7m-systick";
> +       reg = <0xe000e010 0x10>;
> +       clock-frequency = <90000000>;
> +};
> --
> 1.9.1
>
