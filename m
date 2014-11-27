From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 12:45:45 +0100
Subject: [PATCH 01/19] pinctrl: exynos: Add support for Exynos5433
In-Reply-To: <1417073716-22997-2-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <3904347.Bp2gmpYM49@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 16:34:58 Chanwoo Choi wrote:
> +
> +/*
> + * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
> + * four gpio/pin-mux/pinconfig controllers.
> + */
> +struct samsung_pin_ctrl exynos5433_pin_ctrl[] = {
> +       {
> +               /* pin-controller instance 0 data */
> +               .pin_banks      = exynos5433_pin_banks0,
> +               .nr_banks       = ARRAY_SIZE(exynos5433_pin_banks0),
> +               .eint_wkup_init = exynos_eint_wkup_init,
> +               .suspend        = exynos_pinctrl_suspend,
> +               .resume         = exynos_pinctrl_resume,
> +               .label          = "exynos5433-gpio-ctrl0",
> +       }, {
> 

I'm counting nine controllers, not four ;-)

These seem to all be fairly regular, my impression is that with the
move to arm64, you should come up with a new binding that can fully
describe each controller so you don't have to add new code and bindings
for each future SoC that uses the same scheme.

	Arnd
