From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 16 Jun 2012 09:06:36 -0600
Subject: [PATCH] leds: Add DT support for leds-pca9532
In-Reply-To: <1339855851-9171-1-git-send-email-stigge@antcom.de>
References: <1339855851-9171-1-git-send-email-stigge@antcom.de>
Message-ID: <4FDCA0FC.5000409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2012 08:10 AM, Roland Stigge wrote:
> This patch adds DT support for leds-pca9532.

> +++ linux-2.6/Documentation/devicetree/bindings/leds/leds-pca9532.txt

> +- nxp,typecodes: groups of 2 bits for each of the 16 pins:
> +  0: None
> +  1: LED
> +  2: Beep
> +  3: GPIO
> +- nxp,statecodes: groups of 2 bits for each of the 16 pins:
> +  0: off
> +  1: on
> +  2: pwm0
> +  3: pwm1
> +
> +Optional properties:
> +- nxp,psc: array of 2 numbers: PSC values for the two PWM channels (see datasheet)
> +- nxp,pwm: array of 2 numbers: PWM values for the two PWM channels (see datasheet)

Shouldn't that all be exposed using a combination of the pinctrl
bindings that are in 3.5, and the PWM bindings that should be coming in 3.6?
