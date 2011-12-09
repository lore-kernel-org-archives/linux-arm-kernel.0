From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 10 Dec 2011 00:49:11 +0100
Subject: [RFC 1/3] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <20111209170722.GO31337@atomide.com>
References: <1323382390-14892-1-git-send-email-swarren@nvidia.com>
 <1323382390-14892-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYDn0V7SeQuFiFDMxGkybvg6PGf7jxid8ECGB7Azkj3zw@mail.gmail.com>
 <20111209170722.GO31337@atomide.com>
Message-ID: <CACRpkdaco=967cKHUcj9VNKc_HyT7Mw30Z9HVdfgsUsHbps8bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 6:07 PM, Tony Lindgren <tony@atomide.com> wrote:

> - We currently have hard time supporting pin groups with pins
> ?coming from multiple pinmux driver instances

Pin groups are per definiton per-controller inctance. That is a
given side effect of not having a global pin space.

But you can create two groups of the same name on two
pin controllers so that e.g. pinctrl.0 and pinctrl.1 have
a group named "foo", then map both to a certain device
in the board pinmux map.

You will have to request them individually however, like
with two hogs or two pinmux_get() calls specifying the
name of each map, else you will just get the first one.

Not that I've tried it, but that's how it's supposed to work...

Yours,
Linus Walleij
