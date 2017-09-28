From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 28 Sep 2017 18:03:57 +0200
Subject: [PATCH 1/2] clk/ux500: Delete an error message for a failed
 memory allocation in three functions
In-Reply-To: <db799483-7084-8e93-2bfe-2da0e426d08b@users.sourceforge.net>
References: <d23a685d-f8a0-f4ca-078a-414d7b8674ca@users.sourceforge.net>
 <db799483-7084-8e93-2bfe-2da0e426d08b@users.sourceforge.net>
Message-ID: <CAPDyKFo3LUS4fy0U88nqoMgTKszhBwrjMAJvS_3hn5whCg=Yrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 September 2017 at 20:46, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Sep 2017 20:23:58 +0200
>
> Omit extra messages for a memory allocation failure in these functions.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/clk/ux500/clk-prcc.c    | 4 +---
>  drivers/clk/ux500/clk-prcmu.c   | 4 +---
>  drivers/clk/ux500/clk-sysctrl.c | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
> index f50592775c9d..5ca07e6d1f64 100644
> --- a/drivers/clk/ux500/clk-prcc.c
> +++ b/drivers/clk/ux500/clk-prcc.c
> @@ -108,10 +108,8 @@ static struct clk *clk_reg_prcc(const char *name,
>         }
>
>         clk = kzalloc(sizeof(struct clk_prcc), GFP_KERNEL);
> -       if (!clk) {
> -               pr_err("clk_prcc: %s could not allocate clk\n", __func__);
> +       if (!clk)
>                 return ERR_PTR(-ENOMEM);
> -       }
>
>         clk->base = ioremap(phy_base, SZ_4K);
>         if (!clk->base)
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index 6e3e16b2e5ca..c137934f23ab 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
> @@ -259,10 +259,8 @@ static struct clk *clk_reg_prcmu(const char *name,
>         }
>
>         clk = kzalloc(sizeof(struct clk_prcmu), GFP_KERNEL);
> -       if (!clk) {
> -               pr_err("clk_prcmu: %s could not allocate clk\n", __func__);
> +       if (!clk)
>                 return ERR_PTR(-ENOMEM);
> -       }
>
>         clk->cg_sel = cg_sel;
>         clk->is_prepared = 1;
> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> index 8a4e93ce1e42..e0a834c08a04 100644
> --- a/drivers/clk/ux500/clk-sysctrl.c
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -140,10 +140,8 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
>         }
>
>         clk = devm_kzalloc(dev, sizeof(struct clk_sysctrl), GFP_KERNEL);
> -       if (!clk) {
> -               dev_err(dev, "clk_sysctrl: could not allocate clk\n");
> +       if (!clk)
>                 return ERR_PTR(-ENOMEM);
> -       }
>
>         /* set main clock registers */
>         clk->reg_sel[0] = reg_sel[0];
> --
> 2.14.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
