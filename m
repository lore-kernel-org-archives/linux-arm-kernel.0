From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 20:32:42 +0200
Subject: [PATCH v9 2/3] ARM: bcm281xx: Enable GPIO driver
In-Reply-To: <1378836423-12467-3-git-send-email-markus.mayer@linaro.org>
References: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
 <1378836423-12467-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <CACRpkday0HxWJXQWQzPpVxymw=VNC-aYfwqR=b60KyaNO8Fn9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 8:07 PM, Markus Mayer <markus.mayer@linaro.org> wrote:
> Turn on the bcm281xx GPIO driver in the kernel configuration.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> ---
>  arch/arm/mach-bcm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 69d67f7..7f6fca8 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -9,7 +9,7 @@ config ARCH_BCM
>         select CLKSRC_OF
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_TIME
> -       select GPIO_BCM
> +       select GPIO_BCM_KONA

I don't know if you have to select OF_GPIO here to get it working
now that I added that dependency?

Or maybe I should let the Kconfig for the driver select OF_GPIO?

Yours,
Linus Walleij
