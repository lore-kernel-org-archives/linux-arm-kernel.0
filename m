From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Apr 2014 17:46:19 +0100
Subject: [PATCH] arm64:kconfig: make default for CONFIG_COMPAT
In-Reply-To: <1397462883-12740-1-git-send-email-chanho.min@lge.com>
References: <1397462883-12740-1-git-send-email-chanho.min@lge.com>
Message-ID: <20140414164618.GC12916@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 09:08:03AM +0100, Chanho Min wrote:
> 'make savedefconfig' doesn't generate defconfig properly due to
> missing COMPAT default. So Add default and set to yes.

I thought a missing `default' line in a Kconfig entry meant that the option
ended up defaulting to 'n'. What exactly is the problem you are seeing?

Will

> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>  arch/arm64/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4907b85..93b7531 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -294,6 +294,7 @@ source "fs/Kconfig.binfmt"
>  
>  config COMPAT
>  	bool "Kernel support for 32-bit EL0"
> +	default y
>  	depends on !ARM64_64K_PAGES
>  	select COMPAT_BINFMT_ELF
>  	select HAVE_UID16
> -- 
> 1.7.9.5
> 
> 
