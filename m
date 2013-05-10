From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 May 2013 09:32:05 +0900
Subject: [PATCH v5] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <201305031552.45410.heiko@sntech.de>
References: <201305031552.45410.heiko@sntech.de>
Message-ID: <046401ce4d15$ccba0c80$662e2580$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> The s3c24xx pins follow a similar pattern as the other Samsung SoCs and
> can therefore reuse the already introduced infrastructure.
> 
> The s3c24xx SoCs have one design oddity in that the first 4 external
> interrupts do not reside in the eint pending register but in the main
> interrupt controller instead. We solve this by forwarding the external
> interrupt from the main controller into the irq domain of the pin bank.
> The masking/acking of these interrupts is handled in the same way.
> 
> Furthermore the S3C2412/2413 SoCs contain another oddity in that they
> keep the same 4 eints in the main interrupt controller and eintpend
> register and requiring ack operations to happen in both. This is solved
> by using different compatible properties for the wakeup eint node which
> set a property accordingly.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Looks good to me.

Linus, if you want me to take into samsung tree, please let me know.

Thanks.

- Kukjin

> ---
> changes since v4:
> - fix wrong s3c2413 naming
>   between s3c2412 and s3c2413, the s3c2412 is the base type. Till v4 the
>   naming was mixed up, with parts being labeled as s3c2412* and others
>   as s3c2413*. Fix this by renaming the s3c2413* parts to s3c2412.
>   No functional changes.
> 
> changes since v3:
> - address comments from Sylwester Nawrocki:
>   (typos, wrong comments, etc)
> 
> changes since v2:
> - address more comments from Tomasz Figa:
>   * remove obsolete ctrl_type references
>   * remove redundant check for parent_chip
>   * update docs and commit message
> 
> changes since v1:
> - address comments from Tomasz Figa:
>   * split handling functions for eints 0-3 for s3c2412 and all others
>   * change the handling for s3c2412 eints 0-3 in that they now use
>     chained_irq_* for the outer parent interrupt
> 
>  .../bindings/pinctrl/samsung-pinctrl.txt           |    8 +
>  drivers/gpio/gpio-samsung.c                        |    4 +
>  drivers/pinctrl/Kconfig                            |    5 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-s3c24xx.c                  |  652 ++++++++++++++++++++
>  drivers/pinctrl/pinctrl-samsung.c                  |   10 +
>  drivers/pinctrl/pinctrl-samsung.h                  |    4 +
>  7 files changed, 684 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/pinctrl/pinctrl-s3c24xx.c
> 
[...]
