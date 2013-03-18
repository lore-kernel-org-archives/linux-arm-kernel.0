From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Mar 2013 22:38:58 +0100
Subject: [PATCH 2/6] pinctrl: samsung: Include pinctrl-exynos driver data
 conditionally
In-Reply-To: <1363642315-10331-3-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
 <1363642315-10331-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1733680.zsxXgkCci5@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 of March 2013 22:31:51 Tomasz Figa wrote:
> Since pinctrl-samsung is a common part of the pin control support for
> several Samsung SoCs, it can be compiled without Exynos support enabled.
> 
> This patch surrounds Exynos-specific driver data with ifdefs to include
> them only when support for Exynos is enabled.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-samsung.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-samsung.c
> b/drivers/pinctrl/pinctrl-samsung.c index b1d4ac8..f1fb562 100644
> --- a/drivers/pinctrl/pinctrl-samsung.c
> +++ b/drivers/pinctrl/pinctrl-samsung.c
> @@ -968,10 +968,12 @@ static int samsung_pinctrl_probe(struct
> platform_device *pdev) }
> 
>  static const struct of_device_id samsung_pinctrl_dt_match[] = {
> +#ifdef CONFIG_PINCTRL_EXYNOS4

Oops... This should be CONFIG_PINCTRL_EXYNOS. It used to be EXYNOS4 in 
Kgene's tree (on which I usually base my patches) for some time, but it no 
longer is, but I forgot to change this during rebae.

Linus, if remaining patches turned out to be OK, would you fix this when 
applying?

Best regards,
Tomasz
