From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 8 Oct 2011 18:22:50 +0800
Subject: [PATCH 26/26] ARM: pxa: sharpsl pm needs SPI
In-Reply-To: <1317499438-14058-27-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-27-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO_vpHwTaBt06RQYj88FTg9ZOi4xCBoMMJ-roKWd64-jBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The sharpsl code selects the max1111 spi driver, so it must also
> ensure that SPI itself is enabled. The platform does not work
> without max1111.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

> ---
> ?arch/arm/mach-pxa/Kconfig | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 3733971..6dee18e 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -710,6 +710,8 @@ config SHARPSL_PM
> ?config SHARPSL_PM_MAX1111
> ? ? ? ?bool
> ? ? ? ?select HWMON
> + ? ? ? select SPI
> + ? ? ? select SPI_MASTER
> ? ? ? ?select SENSORS_MAX1111
>
> ?config PXA_HAVE_ISA_IRQS
> --
> 1.7.5.4
>
>
