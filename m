From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 4 Jun 2017 18:06:07 -0300
Subject: [PATCH] ARM: dts: imx: Fix Ethernet PHY reset polarity
In-Reply-To: <20170604184937.GA10273@lunn.ch>
References: <1496597475-1361-1-git-send-email-festevam@gmail.com>
 <20170604184937.GA10273@lunn.ch>
Message-ID: <CAOMZO5AP3nNob79G++uDAUBPpzu0dc2gaZnA_wtqbk1vmyFNUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sun, Jun 4, 2017 at 3:49 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Hi Fabio
>
> Device tree bindings are supposed to be stable. So we can never fix

Correct and this patch does not cause device tree to be unstable.

> the FEC to respect the flag. This change to 'GPIO_ACTIVE_LOW' makes
> the suggestion the flag is used, and can be set to GPIO_ACTIVE_HIGH.
> If i were to change the value, i would set it to 42, or something new
> like GPIO_FLAGS_BROKEN.

GPIO_ACTIVE_LOW reflects the real polarity of the pin, so the dts
should reflect the reality.

All the users of FEC in mainline are active low, so better fix the dts
description.

It is true that the FEC driver ignores the GPIO polarity and assume
active-low by default, unless ''phy-reset-active-high' is passed.

However device tree should properly describe the hardware,
independently of the kernel driver details and this is what this patch
does.
