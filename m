From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Aug 2012 14:31:43 +0200
Subject: [PATCH 2/2] ARM: EXYNOS: Enable PINCTRL config option for Exynos4
 device tree enabled platform
In-Reply-To: <1345061442-32378-3-git-send-email-thomas.abraham@linaro.org>
References: <1345061442-32378-1-git-send-email-thomas.abraham@linaro.org>
 <1345061442-32378-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkda9BiGejU+Qs=1CqKgLxLGumcM4QZOb_og-aAAmKr-0VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:10 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> This enables support for Samsung and Exynos4 pinctrl driver for device
> tree enabled Exynos4 platforms.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index b5b4c8c..ad96c59 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -405,6 +405,7 @@ config MACH_EXYNOS4_DT
>         select USE_OF
>         select ARM_AMBA
>         select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
> +       select PINCTRL

I don't think this works, since PINCTRL_SAMSUNG is not default "y"
(nor should it be).

For the platforms I converted I had to select both the subsystem and
the indivudual driver, as is already done for some GPIO controllers
for example:

select PINCTRL
select PINCTRL_SAMSUNG

Yours,
Linus Walleij
