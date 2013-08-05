From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 5 Aug 2013 14:47:17 +0530
Subject: [PATCH] mach-ks8695/Kconfig: Make MACH_KS8695 depends on PCI
In-Reply-To: <1375693624-21548-1-git-send-email-manjunath.goudar@linaro.org>
References: <1375693624-21548-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <CAKohpomo-J1Y_Zf8OLCCvrgfqi7m7tBju=rPp9+wuDAYL_-x7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2013 14:37, Manjunath Goudar <manjunath.goudar@linaro.org> wrote:
> From: root <root@si-cspbld63.lge.net>

:)

> This patch adds a Kconfig dependency on MACH_KS8695,MACH_CM* or MACH_IM*
> being available before PCI can be enabled. Without this patch,build system

Add Space after ','

> can lead to issues. This was discovered during randconfig testing,
> without PCI if any one of MACH_KS8695,MACH_CM* or MACH_IM* being enabled,

Same here.

> leading to the following error:
>
> LD      init/built-in.o
> arch/arm/mach-ks8695/built-in.o: In function `og_register_pci':
> arch/arm/mach-ks8695/board-og.c:47:undefined reference to `ks8695_init_pci'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Deepak Saxena <dsaxena@linaro.org>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-ks8695/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
> index a545976..29d7d9f 100644
> --- a/arch/arm/mach-ks8695/Kconfig
> +++ b/arch/arm/mach-ks8695/Kconfig
> @@ -5,6 +5,7 @@ menu "Kendin/Micrel KS8695 Implementations"
>  config MACH_KS8695
>         bool "KS8695 development board"
>         select MIGHT_HAVE_PCI
> +       depends on PCI

You need both PCI and MIGHT_HAVE_PCI? Don't know but it looks
like defconfig is missing PCI stuff.. and MIGHT_HAVE_PCI is enough
here?
