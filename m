From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 22:22:37 +0100
Subject: [PATCH] ARM64: enable CONFIG_KEYS_COMPAT in Kconfig
In-Reply-To: <1485190992-86476-1-git-send-email-bilal.amarni@gmail.com>
References: <1485190992-86476-1-git-send-email-bilal.amarni@gmail.com>
Message-ID: <6063453.l76hsdyeRH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 23, 2017 6:03:12 PM CET Bilal Amarni wrote:
> Currently in 32-bit userspace calling the keyctl syscall returns an ENOSYS error.
> 
> This makes sure the compatibility wrapper is registered.
> 
> Signed-off-by: Bilal Amarni <bilal.amarni@gmail.com>

While this looks technically correct, it doesn't seem very nice to the
other 64-bit architectures that may also be missing this.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1117421..d76f70b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1030,6 +1030,10 @@ config SYSVIPC_COMPAT
>         def_bool y
>         depends on COMPAT && SYSVIPC
>  
> +config KEYS_COMPAT
> +       def_bool y
> +       depends on COMPAT && KEYS
> +

I see four copies of this in existing architectures, but none for
mips, parisc or tile. How about just moving this next to CONFIG_KEYS?

	Arnd
