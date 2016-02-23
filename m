From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Feb 2016 15:52:20 -0600
Subject: [PATCH 1/3 v2] irqchip: gic/realview: support more RealView DCC
 variants
In-Reply-To: <1456149661-19118-1-git-send-email-linus.walleij@linaro.org>
References: <1456149661-19118-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160223215219.GA26531@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 03:01:01PM +0100, Linus Walleij wrote:
> In the add-on file for the GIC dealing with the RealView family
> we currently only handle the PB11MPCore, let's extend this to
> manage the RealView EB ARM11MPCore as well. The Revision B of the
> ARM11MPCore core tile is a bit special and needs special handling
> as it moves a system control register around at random.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Detect syscon register location based on the syscon compatible
>   string instead of the GIC compatible string, just define one
>   compatible string for the 11mp test chip GIC.
> - Consistently return -ENODEV
> This can be applied in isolation from the other patches so Marc
> one you're happy with it, please take it into the IRQchip tree.
> ---
>  .../bindings/interrupt-controller/arm,gic.txt      |  1 +
>  drivers/irqchip/irq-gic-realview.c                 | 44 +++++++++++++++++++---
>  2 files changed, 39 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
