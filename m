From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 15:00:01 -0600
Subject: [PATCH 5/7] net: rfkill: gpio: add device tree support
In-Reply-To: <1397544101-18135-6-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-6-git-send-email-wens@csie.org>
Message-ID: <534D9DD1.2070004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 12:41 AM, Chen-Yu Tsai wrote:

Patch description?

> diff --git a/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt

> +Required properties:

> +- gpios		: At most two GPIO phandles
> +- gpio-names	: Shall be "reset" or "shutdown", matching gpios.
> +		  If both are provided, the "reset" GPIO is toggled first.

As Maxime mentioned, this is an unusual way of defining GPIOs. If this
new way is acceptable, then I'd suggest more precise wording, e.g.:

- gpios: Must contain an entry for each entry in gpio-names.
  See ../gpio/gpio.txt for details.
- gpio-names: May contain any or all of the following entries:
  - reset
  - shutdown

> +- rfkill-type	: Type of RFKILL device: 1 for WiFi, 2 for BlueTooth, etc.
> +		  See include/uapi/linux/rfkill.h for all valid values

It would be nice if include/dt-bindings/rfkill-gpio.h existed and
contained e.g.:

#define RFKILL_TYPE_BLUETOOTH 2

So that:

> +Example:
> +
> +	rfkill_bt {
...
> +		rfkill-type = <2>;

Could be written as:

		rfkill-type = <RFKILL_TYPE_BLUETOOTH>;
