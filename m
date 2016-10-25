From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 25 Oct 2016 11:48:02 +0200
Subject: [PATCH v2 1/4] PM / Domains: Add generic data pointer to genpd
 data struct
In-Reply-To: <20161019203347.17893-2-d-gerlach@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
 <20161019203347.17893-2-d-gerlach@ti.com>
Message-ID: <CAPDyKFr=afF5w8jeV+1VCNGiav5SXSf6Cxu3OOmzYzOuu2RjPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2016 at 22:33, Dave Gerlach <d-gerlach@ti.com> wrote:
> Add a void *data pointer to struct generic_pm_domain_data. Because this
> exists for each device associated with a genpd it will allow us to
> assign per-device data if needed on a platform for control of that
> specific device.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_domain.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a09fe5c009c8..9c0a897fe605 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -105,6 +105,7 @@ struct generic_pm_domain_data {
>         struct pm_domain_data base;
>         struct gpd_timing_data td;
>         struct notifier_block nb;
> +       void *data;
>  };
>
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
> --
> 2.9.3
>
