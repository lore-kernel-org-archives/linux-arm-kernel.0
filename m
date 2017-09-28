From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 28 Sep 2017 18:04:18 +0200
Subject: [PATCH 2/2] clk/ux500: Improve a size determination in three
 functions
In-Reply-To: <1991a7d3-59b8-1a5f-dcef-a0a493e3829d@users.sourceforge.net>
References: <d23a685d-f8a0-f4ca-078a-414d7b8674ca@users.sourceforge.net>
 <1991a7d3-59b8-1a5f-dcef-a0a493e3829d@users.sourceforge.net>
Message-ID: <CAPDyKFozYOX3P=pgHsWWV+2dsmwQVUc4d422Buf8+frChyPpig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 September 2017 at 20:47, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Sep 2017 20:30:53 +0200
>
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/clk/ux500/clk-prcc.c    | 2 +-
>  drivers/clk/ux500/clk-prcmu.c   | 2 +-
>  drivers/clk/ux500/clk-sysctrl.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
> index 5ca07e6d1f64..7cfb59c9136d 100644
> --- a/drivers/clk/ux500/clk-prcc.c
> +++ b/drivers/clk/ux500/clk-prcc.c
> @@ -107,7 +107,7 @@ static struct clk *clk_reg_prcc(const char *name,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       clk = kzalloc(sizeof(struct clk_prcc), GFP_KERNEL);
> +       clk = kzalloc(sizeof(*clk), GFP_KERNEL);
>         if (!clk)
>                 return ERR_PTR(-ENOMEM);
>
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index c137934f23ab..9d1f2d4550ad 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
> @@ -258,7 +258,7 @@ static struct clk *clk_reg_prcmu(const char *name,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       clk = kzalloc(sizeof(struct clk_prcmu), GFP_KERNEL);
> +       clk = kzalloc(sizeof(*clk), GFP_KERNEL);
>         if (!clk)
>                 return ERR_PTR(-ENOMEM);
>
> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> index e0a834c08a04..7c0403b733ae 100644
> --- a/drivers/clk/ux500/clk-sysctrl.c
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -139,7 +139,7 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       clk = devm_kzalloc(dev, sizeof(struct clk_sysctrl), GFP_KERNEL);
> +       clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
>         if (!clk)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.14.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
