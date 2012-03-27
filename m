From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2012 16:19:13 +0000
Subject: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <201203271619.13320.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 January 2012, Thomas Abraham wrote:
> +
> +Optional Board Specific Properties:
> +- samsung,sdhci-bus-width: Number of data lines connected to the controller.
> +  Note: This excludes the clock,command and card detect lines. If this property
> +  is not specified, default value is 1.
> +
> +- samsung,cd-gpio-invert: If 'samsung,sdhci-cd-gpio' card detect method is
> +  selected, this property can be optionally specified to invert the value of
> +  external card detect gpio line.
> +
> +- One of the following properties for card detect type.
> +  - samsung,sdhci-cd-internal: Card detect line from the card slot  is
> +    connected to the card detect pad of the sdhci controller. A gpio is
> +    used for this connection (with possible pin function settings).
> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
> +    is used a card detect line. This gpio line is not connected to card detect
> +    pad of the sdhci controller.
> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
> +    detect the presence of the card. (DEFAULT, if no card detect property
> +    is specified).
> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
> +    permanently connected to the sdhci controller.
> +
> +- gpio-cd: The gpio to be used as card detect line for
> +  'samsung,sdhci-cd-internal' or 'samsung,sdhci-cd-gpio' card detection method.
> +  The gpio specifier format depends on the gpio controller.

These bindings came up in a discussion IRC today. I think it's rather bad that
we can't agree on a common way to name the properties for mmc. We have
bindings being proposed or already included from Anton, Stephen, Shawn,
Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
for card detect and write protect, as well properties to define the bus
width and high-speed modes, but we seem to have almost as many different
definitions of these as we have drivers.

Can we please come up with a common binding for these?

	Arnd
