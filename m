From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Oct 2014 17:10:17 +0100
Subject: [PATCH] arm64: Add KEYS_COMPAT to Kconfig & enable
In-Reply-To: <1413316871-27404-1-git-send-email-spang@chromium.org>
References: <1413316871-27404-1-git-send-email-spang@chromium.org>
Message-ID: <20141020161017.GL20301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 09:01:11PM +0100, Michael Spang wrote:
> This enables the keyctl compat syscall.
> 
> Signed-off-by: Michael Spang <spang@chromium.org>
> ---
>  arch/arm64/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ac9afde..35c3103 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -461,6 +461,11 @@ source "arch/arm64/Kconfig.debug"
>  
>  source "security/Kconfig"
>  
> +config KEYS_COMPAT
> +	bool
> +	depends on COMPAT && KEYS
> +	default y

I'm curious as to why this requires a Kconfig option, whilst other compat
system calls do not. The core code is already using COMPAT_SYSCALL_DEFINE,
so why can't the architecture just plumb the compat syscall table and be
done with it?

Failing that, the pattern used elsewhere involves __ARCH_WANT_COMPAT_*
#defines.

Will
