From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Sep 2013 13:36:33 +0900
Subject: [PATCH] pinctrl: Correct number of pins for s5pv210
In-Reply-To: <1380035051-24526-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1380035051-24526-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <02bc01ceba71$fa8bcda0$efa368e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mateusz Krawczuk wrote:
> 
> Values of pins in table s5pv210 bank are incorrect. This patch correct
> values.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This fix is correct,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> ---
>  drivers/pinctrl/pinctrl-exynos.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-
> exynos.c
> index 2689f8d..155b1b3 100644
> --- a/drivers/pinctrl/pinctrl-exynos.c
> +++ b/drivers/pinctrl/pinctrl-exynos.c
> @@ -663,18 +663,18 @@ static void exynos_pinctrl_resume(struct
> samsung_pinctrl_drv_data *drvdata)
>  /* pin banks of s5pv210 pin-controller */
>  static struct samsung_pin_bank s5pv210_pin_bank[] = {
>  	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
> -	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
> +	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpa1", 0x04),
>  	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
>  	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
>  	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
>  	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
> -	EXYNOS_PIN_BANK_EINTG(4, 0x0c0, "gpd1", 0x18),
> -	EXYNOS_PIN_BANK_EINTG(5, 0x0e0, "gpe0", 0x1c),
> -	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpe1", 0x20),
> -	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gpf0", 0x24),
> +	EXYNOS_PIN_BANK_EINTG(6, 0x0c0, "gpd1", 0x18),
> +	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpe0", 0x1c),
> +	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpe1", 0x20),
> +	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpf0", 0x24),
>  	EXYNOS_PIN_BANK_EINTG(8, 0x140, "gpf1", 0x28),
>  	EXYNOS_PIN_BANK_EINTG(8, 0x160, "gpf2", 0x2c),
> -	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpf3", 0x30),
> +	EXYNOS_PIN_BANK_EINTG(6, 0x180, "gpf3", 0x30),
>  	EXYNOS_PIN_BANK_EINTG(7, 0x1a0, "gpg0", 0x34),
>  	EXYNOS_PIN_BANK_EINTG(7, 0x1c0, "gpg1", 0x38),
>  	EXYNOS_PIN_BANK_EINTG(7, 0x1e0, "gpg2", 0x3c),
> --
> 1.8.1.2
