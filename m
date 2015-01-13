From: keescook@chromium.org (Kees Cook)
Date: Tue, 13 Jan 2015 06:41:18 -0800
Subject: [PATCH] ARM: ARM_KERNMEM_PERMS only works with MMU enabled
In-Reply-To: <1976703.4VfV2sWda0@wuerfel>
References: <1976703.4VfV2sWda0@wuerfel>
Message-ID: <CAGXu5jK=we1RBr225jSLsJC6o-WxwN4KQnvtAVbSwv+UEfwafQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 6:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The recently added ARM_KERNMEM_PERMS feature works by manipulating
> the kernel page tables, which obviously requires an MMU. Trying
> to enable this feature when the MMU is disabled results in a lot
> of compile errors in mm/init.c, so let's add a Kconfig dependency
> to avoid that case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah, good call.

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index eaaf196fe4e1..0051cd924fb1 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -1010,6 +1010,7 @@ config ARCH_SUPPORTS_BIG_ENDIAN
>
>  config ARM_KERNMEM_PERMS
>         bool "Restrict kernel memory permissions"
> +       depends on MMU
>         help
>           If this is set, kernel memory other than kernel text (and rodata)
>           will be made non-executable. The tradeoff is that each region is
>



-- 
Kees Cook
Chrome OS Security
