From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:36:49 -0600
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1350569623-4699-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1350569623-4699-1-git-send-email-maxime.ripard@free-electrons.com>
 <1350569623-4699-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50808481.6040501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 08:13 AM, Maxime Ripard wrote:
> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
> bindings are inspired by the one found in the i2c-mux-pinctrl driver.

> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

> +Optional properties:
> +- idle-state: value to set to the muxer when idle. When no value is
> +  given, it defaults to the first value in the array.

That's inconsistent with the following text that appears later (and
describes what the driver actually does):

> +If an idle state is defined, using the idle-state (optional) property,
> +whenever an access is not being made to a device on a child bus, the
> +idle value will be programmed into the GPIOs.
> +
> +If an idle state is not defined, the most recently used value will be
> +left programmed into hardware whenever no access is being made of a
> +device on a child bus.
