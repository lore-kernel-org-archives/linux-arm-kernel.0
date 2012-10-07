From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 08 Oct 2012 09:44:49 +1300
Subject: [PATCH] arm: vt8500: Fix build warning in uncompress.h [for 3.7]
In-Reply-To: <1349640491-25606-1-git-send-email-linux@prisktech.co.nz>
References: <1349640491-25606-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1349642689.19187.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-08 at 09:08 +1300, Tony Prisk wrote:
> This removes a build-time warning in uncompress.h due to incorrectly
> cast values being passed to readb/writeb.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/mach-vt8500/include/mach/uncompress.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
> index bb9e2d2..1344d9f 100644
> --- a/arch/arm/mach-vt8500/include/mach/uncompress.h
> +++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
> @@ -15,7 +15,7 @@
>   *
>   */
>  
> -#define UART0_PHYS 0xd8200000
> +#define UART0_PHYS	(void *)0xd8200000
>  #include <asm/io.h>
>  
>  static void putc(const char c)

Please ignore this patch - I will correct as per Russell's advice.

Regards
Tony P
