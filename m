From: bp@alien8.de (Borislav Petkov)
Date: Tue, 5 Mar 2013 12:58:07 +0100
Subject: [PATCH v3 -next 5/5] Kconfig: Make x86 and arm kernels default
 to the LZ4-compressed
In-Reply-To: <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
Message-ID: <20130305115807.GC4914@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 08:47:36PM +0900, Kyungsik Lee wrote:
> This patch makes x86 and arm kernels default to the LZ4-compressed
> to test new LZ4 code in the linux-next. This is requested by
> Andrew Morton.
> 
> Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index fc8eb1f..de3cb00 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -138,7 +138,7 @@ config HAVE_KERNEL_LZ4
>  
>  choice
>  	prompt "Kernel compression mode"
> -	default KERNEL_GZIP
> +	default KERNEL_LZ4

Do I understand it correctly that when this thing gets committed, kernel
builds on all systems missing the lz4 tool will fail and everybody
should go running to get it so that everybody can build kernels again?

WTF?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
