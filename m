From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 6 Oct 2016 10:38:52 +0200
Subject: [PATCH 2/8] PM / Domain: Add residency property to genpd states
In-Reply-To: <1475699519-109623-3-git-send-email-lina.iyer@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAPDyKFqw-yo8Ha-PJP3z1wc64Nq1QVr=U4V=0HEEh+BEPd6fKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
> Residency of a domain's idle state indicates that the minimum idle time
> for the domain's idle state to be beneficial for power. Add the
> parameter to the state node. Future patches, will use the residency
> value in the genpd governor to determine if it is worth while to enter
> an idle state.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_domain.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bd1ffb9..c113713 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -38,6 +38,7 @@ struct gpd_dev_ops {
>  struct genpd_power_state {
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
> +       s64 residency_ns;
>  };
>
>  struct generic_pm_domain {
> --
> 2.7.4
>
