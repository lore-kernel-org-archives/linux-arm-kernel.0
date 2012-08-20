From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 16:25:05 +0200
Subject: [PATCH 04/11] pinctrl: mvebu: add pinctrl driver for Armada 370
In-Reply-To: <1344689809-6223-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdYNZar7865-T12J37h3AWA9-8R1R5tymuOhaB0b3ddEAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This pinctrl driver is not a full-blown pinctrl driver from scratch:
> it relies on the common pinctrl-mvebu driver, which is used for all
> Marvell EBU SoCs.

Good!

> +config PINCTRL_ARMADA_370
> +       bool "Support for Marvell Armada 370 SoCs"
> +       depends on PINCTRL_MVEBU
> +       depends on MACH_ARMADA_370_XP

select PINCTRL_MVEBU simply?

And then have the Armada Kconfig

select PINCTRL
select PINCTRL_ARMADA_370

This machine doesn't seem to depend in the MVEBU driver, I guess it's
the same ARCH as something else, oh well. Still suspect the
MVEBU driver should depend on PLAT_ORION until proven
wrong.

(...)
> +static int __devinit armada_370_pinctrl_probe(struct platform_device *pdev)
> +{
> +       struct mvebu_pinctrl_soc_info *soc = &armada_370_pinctrl_info;
> +
> +       soc->variant = 0;

Shouldn't this be a #defined thing or something. "variant 0" doesn't
tell me much.

No further comments, looking good.

Yours,
Linus Walleij
