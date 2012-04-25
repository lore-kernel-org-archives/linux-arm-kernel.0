From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Apr 2012 09:48:33 -0600
Subject: [PATCHv4 1/2] drivers: input: keypad: Add device tree support
In-Reply-To: <1335346004-18108-1-git-send-email-sourav.poddar@ti.com>
References: <1335346004-18108-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <4F981CD1.2050007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 03:26 AM, Sourav Poddar wrote:
> Update the Documentation with omap4 keypad device tree
> binding information.
> Add device tree support for omap4 keypad driver.

> diff --git a/Documentation/devicetree/bindings/input/omap-keypad.txt b/Documentation/devicetree/bindings/input/omap-keypad.txt

> +Required Board Specific Properties, in addition to those specified by
> +the shared matrix-keyboard bindings:
> +- keypad,num-rows: Number of row lines connected to the keypad
> +  controller.
> +
> +- keypad,num-columns: Number of column lines connected to the
> +  keypad controller.

I'm not sure if "keypad," is the appropriate prefix here. If the
properties are specific to this one TI/OMAP binding, "ti," might be a
better prefix. However, if they're more generally applicable, maybe
"linux," to match "linux,keymap"?

> +Optional Properties specific to linux:
> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.

It's probably worth considering whether num-rows/columns should be part
of matrix-keyboard.txt, and whether linux,keypad-no-autorepeat should be
part of some core keyboard binding. Some of the properties in
tegra-kbc.txt might be worth generalizing too (debounce/repeat delay,
ghost filter)?

> +Example:
> +        keypad at 4ae1c000{
> +                compatible = "ti,omap4-keypad";
> +                keypad,num-rows = <2>;
> +                keypad,num-columns = <8>;
> +		linux,keypad-no-autorepeat;
> +	};
