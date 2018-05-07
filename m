From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2018 14:02:25 -0700
Subject: [PATCH v2 2/2] ARM: dts: am335x: Replaced register offsets with
 defines
In-Reply-To: <20180505085921.5513-3-cquast@baylibre.com>
References: <20180505085921.5513-1-cquast@baylibre.com>
 <20180505085921.5513-3-cquast@baylibre.com>
Message-ID: <20180507210225.GS98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for updating these, adding Linus Walleij to Cc too.

* Christina Quast <cquast@baylibre.com> [180505 09:02]:
> The defines are taken from dt-bindings/pinctrl/am335x.h

If we're going to replace all of these, I'd go a step further
where we make pinctrl-single use the newish #pinctrl-cells but
set it to 2 instead of 1. Then set the pull flags as one value
using the generic pinctrl defines and the second value being
the selected mux mode.

Then the offset really should be from the padconf mux area,
not from the control module base. And then we would just have
a new macro for these being:

AM33XX_PINCTRL(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)

Where the PIN_INPUT ideally would be a Linux generic define.

Otherwise we'd be churning these same files over and
over.

Regards,

Tony
