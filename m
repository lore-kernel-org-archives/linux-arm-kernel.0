From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 9 Mar 2016 09:31:21 +0100
Subject: [PATCH] pinctrl: pxa2xx: export symbols
In-Reply-To: <1457489509-5680-1-git-send-email-linus.walleij@linaro.org>
References: <1457489509-5680-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160309083121.GS8136@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 09:11:49AM +0700, Linus Walleij wrote:
> The pxa2xxx fails some automated builds because of unexported
> symbols.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

There is 3a5242e648a8d009f0e0fd47867592e5265374b6 in linus/master which
does a part of this patch already.

Apart from that I don't understand the patch. The only user of
pxa2xx_pinctrl_init is drivers/pinctrl/pxa/pinctrl-pxa27x.c[1] and this
is built into the same module as pinctrl-pxa2xx.o. So without testing I
wonder in which configuration this fails to build.

Best regards
Uwe

[1] git grep -E pxa2xx_pinctrl_\(in\|ex\)it next/master
    git grep -E pxa2xx_pinctrl_\(in\|ex\)it linus/master

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
