From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Mar 2017 09:20:43 +0100
Subject: [PATCH v4 2/5] PM / Domains: Do not check if simple providers
 have phandle cells
In-Reply-To: <1488882154-21485-3-git-send-email-d-gerlach@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-3-git-send-email-d-gerlach@ti.com>
Message-ID: <CAPDyKFoEeErp7heeKK1UgcH=XU-LYyJUsRqH60cJzb5YyTY6gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 March 2017 at 11:22, Dave Gerlach <d-gerlach@ti.com> wrote:
> There is no reason that a platform genpd driver registered using
> of_genpd_add_provider_simple needs to be constrained to having no cells
> in the "power-domains" phandle. Currently the genpd framework will fail
> if any arguments are passed with for a simple provider but the framework
> does not actually care, so remove the check for phandle argument count.
>
> This will allow greater flexibility for genpd providers to use their own
> arguments that are passed in the phandle and interpret them however they
> see fit.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> v3->v4:
>  Drop ti,sci-id device property and instead describe using phandle cell
>  for id.
>
>  drivers/base/power/domain.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e697dec9d25b..8e0550c27394 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1622,8 +1622,6 @@ static struct generic_pm_domain *genpd_xlate_simple(
>                                         struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
> -       if (genpdspec->args_count != 0)
> -               return ERR_PTR(-EINVAL);
>         return data;
>  }
>
> --
> 2.11.0
>
