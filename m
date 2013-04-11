From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 11 Apr 2013 14:12:57 +0200
Subject: [PATCH v3] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <201304111409.01983.heiko@sntech.de>
References: <201304111409.01983.heiko@sntech.de>
Message-ID: <1706031.H7t4gja446@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Thursday 11 of April 2013 14:09:01 Heiko St?bner wrote:
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
> ---
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
>  drivers/pinctrl/pinctrl-s3c24xx.c                  |  664
> ++++++++++++++++++++ drivers/pinctrl/pinctrl-samsung.c                  |  
> 10 +
>  drivers/pinctrl/pinctrl-samsung.h                  |    4 +
>  7 files changed, 696 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/pinctrl/pinctrl-s3c24xx.c

Looks good to me, thanks for the patch.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework
