From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 2 Oct 2018 15:28:35 +0200
Subject: [PATCH] ARM: makefile: use ARMv3M mode for RiscPC
In-Reply-To: <20181002132026.14931-1-Jason@zx2c4.com>
References: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
 <20181002132026.14931-1-Jason@zx2c4.com>
Message-ID: <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2018 at 15:20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The purpose of CONFIG_CPU_32v3 is to avoid ldrh/strh on the RiscPC,
> which is pretty much an ARMv4 device, except its bus will choke on the
> half-words. The way to make the C compiler not output ldrh/strh is with
> -march=armv3, which doesn't support them in the ISA. However, this
> prevents certain cryptography code from working that uses instructions
> like umull. Fortunately there's also -march=armv3m that does support
> those, making it possible to continue assembling optimized cryptography
> routines for our beloved RiscPC.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index d1516f85f25d..7fd4bcaf0721 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -74,7 +74,7 @@ endif
>  arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)
>  arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
>  arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 -march=armv4
> -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
> +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>
>  # Evaluate arch cc-option calls now
>  arch-y := $(arch-y)
> --
> 2.19.0
>
