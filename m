From: nm@ti.com (Nishanth Menon)
Date: Mon, 27 Apr 2015 14:30:38 -0500
Subject: [PATCH 2/3] bus: omap_l3_noc: add missed callbacks for
 suspend-to-disk
In-Reply-To: <1430159072-31440-3-git-send-email-grygorii.strashko@linaro.org>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
 <1430159072-31440-3-git-send-email-grygorii.strashko@linaro.org>
Message-ID: <CAGo_u6pryMrJA1HkM84=SH-PRrN2u+f0dzby-LXUbxSiEh9VYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 1:24 PM,  <grygorii.strashko@linaro.org> wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
> Add missed callbacks needed for proper supporting of suspend-to-disk
> by using recently introduced macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>  drivers/bus/omap_l3_noc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> index 11f7982..6ae3884 100644
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@ -300,7 +300,7 @@ static int omap_l3_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>
>  /**
>   * l3_resume_noirq() - resume function for l3_noc
> @@ -346,7 +346,7 @@ static int l3_resume_noirq(struct device *dev)
>  }
>
>  static const struct dev_pm_ops l3_dev_pm_ops = {
> -       .resume_noirq           = l3_resume_noirq,
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, l3_resume_noirq)
>  };
>
>  #define L3_DEV_PM_OPS (&l3_dev_pm_ops)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Acked-by: Nishanth Menon <nm@ti.com>

-- 
---
Regards,
Nishanth Menon
