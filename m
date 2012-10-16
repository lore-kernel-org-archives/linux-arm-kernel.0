From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Oct 2012 13:02:39 +0000
Subject: [PATCH 1/4] leds: leds-ns2: add device tree binding
In-Reply-To: <1350315295-14567-2-git-send-email-simon.guinot@sequanux.org>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <1350315295-14567-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <201210161302.39302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 October 2012, Simon Guinot wrote:
> diff --git a/Documentation/devicetree/bindings/gpio/leds-ns2.txt b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
> new file mode 100644
> index 0000000..1a84969
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
> @@ -0,0 +1,26 @@
> +Binding for dual-GPIO LED found on Network Space v2 (and parents).
> +
> +Required properties:
> +- compatible: "ns2-leds".
> +
> +Each LED is represented as a sub-node of the ns2-leds device.
> +
> +Required sub-node properties:
> +- cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
> +- slow-gpio: Slow LED GPIO. See OF device-tree GPIO specification.
> +
> +Optional sub-node properties:
> +- label: Name for this LED. If omitted, the label is taken from the node name.
> +- linux,default-trigger: Trigger assigned to the LED.

Hi Simon,

I'm not overly familiar with the LED subsystem, but isn't this something
that could be done with the generic gpio-led driver?

If not, is it possible to extend that driver in a way to make it possible
and remove the leds-ns2 driver?

	Arnd
