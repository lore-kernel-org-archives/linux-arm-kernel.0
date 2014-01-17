From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 17:47:45 +0100
Subject: [PATCH RFC 4/6] net: rfkill: gpio: add device tree support
In-Reply-To: <1389941251-32692-5-git-send-email-wens@csie.org>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <1389941251-32692-5-git-send-email-wens@csie.org>
Message-ID: <201401171747.46332.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Chen-Yu Tsai wrote:
> diff --git a/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
> new file mode 100644
> index 0000000..8a07ea4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
> @@ -0,0 +1,26 @@
> +GPIO controlled RFKILL devices
> +
> +Required properties:
> +- compatible   : Must be "rfkill-gpio".
> +- rfkill-name  : Name of RFKILL device
> +- rfkill-type  : Type of RFKILL device: 1 for WiFi, 2 for BlueTooth
> +- NAME_shutdown-gpios  : GPIO phandle to shutdown control
> +                         (phandle must be the second)
> +- NAME_reset-gpios     : GPIO phandle to reset control
> +
> +NAME must match the rfkill-name property. NAME_shutdown-gpios or
> +NAME_reset-gpios, or both, must be defined.
> +

I don't understand this part. Why do you include the name in the
gpios property, rather than just hardcoding the property strings
to "shutdown-gpios" and "reset-gpios"?

The description of hte "rfkill-name" property seems to suggest
that you can only have one logical RFKILL device per device node,
so he names would not be ambiguous.

	Arnd
