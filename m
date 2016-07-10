From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 10 Jul 2016 09:02:38 -0700
Subject: [PATCH v3 2/3] dt-bindings: watchdog: Add Meson GXBB Watchdog
 bindings
In-Reply-To: <1468141867-4172-3-git-send-email-narmstrong@baylibre.com>
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <5782719E.7020002@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2016 02:11 AM, Neil Armstrong wrote:
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/meson-gxbb-wdt.txt      | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> new file mode 100644
> index 0000000..c7fe36f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
> @@ -0,0 +1,16 @@
> +Meson GXBB SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "amlogic,meson-gxbb-wdt"
> +- reg : Specifies base physical address and size of the registers.
> +- clocks : Should be a phandle to the Watchdog clock source, for GXBB the xtal
> +	   is the default clock source.
> +
> +Example:
> +
> +wdt: watchdog at 98d0 {
> +	compatible = "amlogic,meson-gxbb-wdt";
> +	reg = <0 0x98d0 0x0 0x10>;
> +	clocks = <&xtal>;
> +};
>
