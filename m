From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Mar 2018 18:28:15 +0100
Subject: [PATCH v2 21/21] arm64: move GCC version check for
 ARCH_SUPPORTS_INT128 to Kconfig
In-Reply-To: <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20180327172815.GH18435@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 02:29:35PM +0900, Masahiro Yamada wrote:
> This becomes much neater in Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Newly added
> 
>  arch/arm64/Kconfig  | 1 +
>  arch/arm64/Makefile | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7381eeb..0c97f40 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -43,6 +43,7 @@ config ARM64
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> +	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b481b4a..7318165 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -57,8 +57,6 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
>  
> -KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
> -

If this does what it claims to do, then I agree that it's much cleaner!

Acked-by: Will Deacon <will.deacon@arm.com>

Will
