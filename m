From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Mar 2013 11:05:15 -0600
Subject: [PATCHv2 3/7] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <1364015633-18580-4-git-send-email-linux@prisktech.co.nz>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <515083CB.1060908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 11:13 PM, Tony Prisk wrote:
> This patch adds support for the GPIO/pinmux controller found on the VIA
> VT8500 and Wondermedia WM8xxx-series SoCs.
> 
> Each pin within the controller is capable of operating as a GPIO or as
> an alternate function. The pins are numbered according to their control
> bank/bit so that if new pins are added, the existing numbering is maintained.
> 
> All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
> WM8850.

> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt

> +Required properties:

> +- gpio-controller: Marks the device node as a GPIO controller.
> +- #gpio-cells : Should be two. The first cell is the pin number and the
> +  second cell is used to specify optional parameters.

What are those optional parameters? This binding should define them.

> +Optional properties:
> +- wm,pinmux: A value and mask pair describing the configuration changes to
> +  the pinmux register. Only bits marked 1 in the mask will be changed.

This needs more explanation. What does this do and why is it needed?

Other than that, this binding looks fine.
