From: robherring2@gmail.com (Rob Herring)
Date: Fri, 3 Apr 2015 12:10:39 -0500
Subject: [PATCH v5 07/15] dt-bindings: Document the STM32 timer bindings
In-Reply-To: <1428080481-18591-8-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428080481-18591-8-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CAL_JsqJjnsYpPeyrxhPvPZ-iO-Gf_vc3NgUQcmqTawAmcDjBgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 3, 2015 at 12:01 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> This adds documentation of device tree bindings for the
> STM32 timer.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

One minor thing below, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/timer/st,stm32-timer.txt   | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/st,stm32-timer.txt b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
> new file mode 100644
> index 0000000..d3fdeb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
> @@ -0,0 +1,22 @@
> +. STMicroelectronics STM32 timer
> +
> +The STM32 MCUs family has several general-purpose 16 and 32 bits timers.
> +
> +Required properties:
> +- compatible : Should be st,stm32-timer"

Missing quote

> +- reg : Address and length of the register set
> +- clocks : Reference on the timer input clock
> +- interrupts : Reference to the timer interrupt
> +
> +Optional properties:
> +- resets: Reference to a reset controller asserting the timer
> +
> +Example:
> +
> +timer5: timer at 40000c00 {
> +       compatible = "st,stm32-timer";
> +       reg = <0x40000c00 0x400>;
> +       interrupts = <50>;
> +       resets = <&rrc 259>;
> +       clocks = <&clk_pmtr1>;
> +};
> --
> 1.9.1
>
