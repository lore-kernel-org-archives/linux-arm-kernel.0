From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 20 Mar 2014 09:51:48 +0800
Subject: [PATCH 34/62] ARM: pxa: select I2C_GPIO only if I2C is on
In-Reply-To: <1395257399-359545-35-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-35-git-send-email-arnd@arndb.de>
Message-ID: <CAN1soZywvSWKPUxhjdsE+H+ccH-z3+1S01i4NJsccceRtv2K4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 3:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The Arcom/Eurotech VIPER SBC enables the I2C_GPIO driver, but
> that has a dependency on I2C, and causes build failures if I2C
> is disabled. To keep existing configurations running while fixing
> the randconfig problems, this changes the logic to only enable
> I2C_GPIO if I2C is already enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 50f6132..8d9f4f1 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -73,8 +73,7 @@ config ARCH_PXA_IDP
>  config ARCH_VIPER
>         bool "Arcom/Eurotech VIPER SBC"
>         select ARCOM_PCMCIA
> -       select HAVE_PWM
> -       select I2C_GPIO
> +       select I2C_GPIO if I2C=y
>         select ISA
>         select PXA25x
>         select PXA_HAVE_ISA_IRQS
> --
> 1.8.3.2
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
