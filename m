From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 22 Jan 2017 22:51:16 -0800
Subject: [PATCH 1/3] watchdog: add DT bindings for Cortina Gemini
In-Reply-To: <20170122223826.29178-1-linus.walleij@linaro.org>
References: <20170122223826.29178-1-linus.walleij@linaro.org>
Message-ID: <41414806-3f44-6073-6421-b0aaabba4312@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2017 02:38 PM, Linus Walleij wrote:
> This adds DT bindings for the Cortina systems Gemini SoC
> watchdog timer.
>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/watchdog/cortina,gemin-watchdog.txt        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt b/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
> new file mode 100644
> index 000000000000..d8dfb9cc41cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
> @@ -0,0 +1,17 @@
> +Cortina Systems Gemini SoC Watchdog
> +
> +Required properties :
> +- compatible : must be "cortina,gemini-watchdog"
> +- reg : shall contain base register location and length
> +- interrupts : shall contain the interrupt for the watchdog
> +
> +- timeout-sec : shall contain the default watchdog timeout in seconds,
> +                if unset, the default timeout is 13 seconds
> +

The default is a linux driver detail, not a HW detail, and thus probably should not be mentioned here.

> +Example:
> +
> +watchdog at 41000000 {
> +	compatible = "cortina,gemini-watchdog";
> +	reg = <0x41000000 0x1000>;
> +	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +};
>
