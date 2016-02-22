From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:54:42 -0600
Subject: [PATCH 1/3] irqchip: gic/realview: support more RealView DCC
 variants
In-Reply-To: <1455803172-22747-1-git-send-email-linus.walleij@linaro.org>
References: <1455803172-22747-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160222025442.GM15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 02:46:12PM +0100, Linus Walleij wrote:
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
> This can be applied in isolation from the other patches so Marc
> one you're happy with it, please take it into the IRQchip tree.
> 
> There are two compatible strings getting added to the device tree
> bindings so CC to the DT list. No biggie though, just figures out
> exactly what ARM custom GIC flavor it is.
> ---
>  .../bindings/interrupt-controller/arm,gic.txt      |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/irqchip/irq-gic-realview.c                 | 35 ++++++++++++++++++----
>  2 files changed, 32 insertions(+), 5 deletions(-)
