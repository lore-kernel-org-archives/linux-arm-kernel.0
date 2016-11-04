From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Nov 2016 15:40:53 +0100
Subject: [PATCH 4/9] pinctrl: meson: allow gpio to request irq
In-Reply-To: <7hk2cvrtxt.fsf@baylibre.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
 <1476871709-8359-5-git-send-email-jbrunet@baylibre.com>
 <CACRpkdaCZPS45t3eTcjJExOu=YT_YkjNkdpg09jQqvLQOJH=Qw@mail.gmail.com>
 <1477040798.15560.96.camel@baylibre.com>
 <CACRpkdYUVXny57AC9rKX3VRAyooEk_2XLvqe9jOuT3rOaE75rg@mail.gmail.com>
 <ec7c6cc5-cf9a-9c75-4b07-e337064c7d6e@arm.com>
 <1477400900.2482.51.camel@baylibre.com>
 <dee26f0b-e175-f8a0-2b73-08e8e324841c@arm.com>
 <1477405332.2482.87.camel@baylibre.com>
 <bbc268c8-35c3-206a-46b1-62cebef174b2@arm.com>
 <1477409478.2482.113.camel@baylibre.com>
 <CACRpkdbGo4BJOdzkgBrE9jT-rKodd4zssCnOtOuGS+OqV-Uc6Q@mail.gmail.com>
 <1477491766.2482.159.camel@baylibre.com>
 <CACRpkdYqoU0foW1izcZapbgUm+NO4quz9AZZBmts4841BRcigA@mail.gmail.com>
 <7hk2cvrtxt.fsf@baylibre.com>
Message-ID: <CACRpkdbXFv8pnwbajTruUU66JhgfYy=3iG6dex=XpNNOEt7Pqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 5:50 PM, Kevin Hilman <khilman@baylibre.com> wrote:

>> Yes they are all wrong. They should all be using irq_find_mapping().
>
> So, dumb question from someone trying (but having a hard time) to follow
> and understand the rationale...
>
> If it's wrong enough to completely reject, why are changes still being
> merged that are doing it so wrong?  (e.g. like this one[1], just merged
> for v4.9)

It's a bug.

It's that problem that Wolfram brought up in a recent lecture
about maintainer scaling: if noone but the subsystem maintainer
reviews the code, things like this will happen.

I need more review...

> [1] 0eb9f683336d pinctrl: Add IRQ support to STM32 gpios
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pinctrl/stm32/pinctrl-stm32.c?id=0eb9f683336d7eb99a3b75987620417c574ffb57

Alexandre, Maxime: can you please make a patch for the STM32
driver that remove the semantic dependence for .to_irq() to be called
before an interrupt can be used? It should be possible to use
the irqs directly from the irqchip.

Yours,
Linus Walleij
