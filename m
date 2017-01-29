From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 29 Jan 2017 09:29:07 -0800
Subject: [PATCH 1/3 v2] watchdog: add DT bindings for Cortina Gemini
In-Reply-To: <20170128225905.24549-1-linus.walleij@linaro.org>
References: <20170128225905.24549-1-linus.walleij@linaro.org>
Message-ID: <d91d6166-dfce-ff90-5ce7-26ba7d0dd4b7@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2017 02:59 PM, Linus Walleij wrote:
> This adds DT bindings for the Cortina systems Gemini SoC
> watchdog timer.
>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> ChangeLog v1->v2:
> - Make the timeout an optional property
> - Do not mention any Linux defaults if the property is not there
> ---
>  .../bindings/watchdog/cortina,gemin-watchdog.txt        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt b/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
> new file mode 100644
> index 000000000000..bc4b865d178b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
> @@ -0,0 +1,17 @@
> +Cortina Systems Gemini SoC Watchdog
> +
> +Required properties:
> +- compatible : must be "cortina,gemini-watchdog"
> +- reg : shall contain base register location and length
> +- interrupts : shall contain the interrupt for the watchdog
> +
> +Optional properties:
> +- timeout-sec : the default watchdog timeout in seconds.
> +
> +Example:
> +
> +watchdog at 41000000 {
> +	compatible = "cortina,gemini-watchdog";
> +	reg = <0x41000000 0x1000>;
> +	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +};
>
