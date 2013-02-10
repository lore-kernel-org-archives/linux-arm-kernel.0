From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 18:42:19 -0800
Subject: [PATCH 11/14] ARM: ux500: remove irq_base property from
 platform_data
In-Reply-To: <1360093715-6348-12-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-12-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130210024141.GE25302@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 08:48:32PM +0100, Linus Walleij wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> AB8500 GPIO no longer handles its GPIO IRQs. Instead, the AB8500
> core driver has taken back the responsibility. Prior to this
> happening, the AB8500 GPIO driver provided a set of virtual IRQs
> which were used as a pass-through. These virtual IRQs had a base
> of MOP500_AB8500_VIR_GPIO_IRQ_BASE, which was passed though pdata.
> We don't need to do this anymore, so we're pulling out the
> property from the structure.
> 
> Cc: arm at kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Requesting an ACK from the ARM SoC maintainers on this patch.

This patch on its own doesn't apply cleanly at all to arm-soc, I'm guessing
because I need the rest of the series. With the presumption that you're not
going to cause grief from sfr due to excessive conflicts. I.e. please try
merging with arm-soc for-next to see how bad it is:

patch 11-14:

Acked-by: Olof Johansson <olof@lixom.net>

If it's conflict-heavy, we'll stage a topic branch that we can both
pull in.  I'm guessing/hoping that won't be the case though.


-Olof
