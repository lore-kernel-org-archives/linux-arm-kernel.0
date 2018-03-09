From: brendanhiggins@google.com (Brendan Higgins)
Date: Fri, 09 Mar 2018 02:08:45 +0000
Subject: [PATCH 1/2] ARM: npcm: add CONFIG_ARCH_MULTI_V7 dependency
In-Reply-To: <20180307162430.2664523-1-arnd@arndb.de>
References: <20180307162430.2664523-1-arnd@arndb.de>
Message-ID: <CAFd5g45h3wAZtx-4oJb_uLbtDTzSsD6eLM5G0VF=3BBHNmW8YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 8:24 AM Arnd Bergmann <arnd@arndb.de> wrote:

> The top-level CONFIG_ARCH_NPCM symbol is not guarded with a
> dependency, and can be selected for builds of traditional
> (non-multiplatform) builds as well, where it causes a build
> failure:

> arch/arm/boot/Makefile:17: arch/arm/mach-npcm//Makefile.boot: No such
file or directory

> This moves the dependency to avoid that particular condition.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/mach-npcm/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> index 6ff9df2636be..2bc6697c8d97 100644
> --- a/arch/arm/mach-npcm/Kconfig
> +++ b/arch/arm/mach-npcm/Kconfig
> @@ -1,5 +1,5 @@
>   menuconfig ARCH_NPCM
> -       bool "Nuvoton NPCM Architecture"
> +       bool "Nuvoton NPCM Architecture" if ARCH_MULTI_V7
>          select ARCH_REQUIRE_GPIOLIB
>          select USE_OF
>          select PINCTRL
> @@ -10,7 +10,7 @@ if ARCH_NPCM
>   comment "NPCM7XX CPU type"

>   config ARCH_NPCM750
> -       depends on ARCH_NPCM && ARCH_MULTI_V7
> +       depends on ARCH_NPCM
>          bool "Support for NPCM750 BMC CPU (Poleg)"
>          select CACHE_L2X0
>          select CPU_V7
> --
> 2.9.0


Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
