From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Aug 2017 16:39:24 -0500
Subject: [PATCH v3] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <1503418601-9728-1-git-send-email-yamada.masahiro@socionext.com>
References: <1503418601-9728-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170825213924.xhbeiffp3oidclor@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 01:16:41AM +0900, Masahiro Yamada wrote:
> This GPIO controller device is used on UniPhier SoCs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3:
>   - Add .irq_set_affinity() hook
>   - Use irq_domain_create_hierarchy() instead of legacy
>     irq_domain_add_hierarchy().
> 
> Changes in v2:
>   - Remove +32 offset for parent interrupts to follow the GIC
>     binding convention
>   - Let uniphier_gpio_irq_alloc() fail if nr_irqs != 1
>   - Allocate gpio_chip statically because just one instance is
>     supported
>   - Fix suspend and resume hooks
> 
>  .../devicetree/bindings/gpio/gpio-uniphier.txt     |  42 ++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   1 +
>  drivers/gpio/Kconfig                               |   7 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-uniphier.c                       | 589 +++++++++++++++++++++
>  include/dt-bindings/gpio/uniphier-gpio.h           |  18 +
>  6 files changed, 658 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
>  create mode 100644 drivers/gpio/gpio-uniphier.c
>  create mode 100644 include/dt-bindings/gpio/uniphier-gpio.h
