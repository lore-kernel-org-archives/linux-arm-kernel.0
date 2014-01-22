From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 22 Jan 2014 20:10:54 +0530
Subject: [PATCH] watchdog: Add sp805_wdt depends on ARM64
In-Reply-To: <1390394643-25443-1-git-send-email-naresh.bhat@linaro.org>
References: <1390394643-25443-1-git-send-email-naresh.bhat@linaro.org>
Message-ID: <CAKohpo=_e-CH9ZGoAxJVsfoFO3pcr0Fi_=QzEc5DnR7EFVewcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2014 18:14,  <naresh.bhat@linaro.org> wrote:
> From: Naresh Bhat <naresh.bhat@linaro.org>
>
> Add sp805_wdt depends on ARM64.
>
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> ---
>  drivers/watchdog/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5be6e91..2385124 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -109,7 +109,7 @@ config WM8350_WATCHDOG
>
>  config ARM_SP805_WATCHDOG
>         tristate "ARM SP805 Watchdog"
> -       depends on ARM && ARM_AMBA
> +       depends on (ARM || ARM64) && ARM_AMBA
>         select WATCHDOG_CORE
>         help
>           ARM Primecell SP805 Watchdog timer. This will reboot your system when

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
