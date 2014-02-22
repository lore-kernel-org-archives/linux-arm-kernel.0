From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 14:58:46 -0500
Subject: [PATCH v4 12/22] ARM: Fix default CPU selection for ARCH_MULTI_V5
In-Reply-To: <1393096504-11844-13-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
 <1393096504-11844-13-git-send-email-andrew@lunn.ch>
Message-ID: <20140222195846.GE7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Sat, Feb 22, 2014 at 08:14:54PM +0100, Andrew Lunn wrote:
> CPU_ARM926T should be selected if no other CPU is. Put the ! in the
> right place so this works.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please put this in rmk's patch tracker:

Fixes: 24e860fbfdb1c ("ARM: multiplatform: always pick one CPU type")
Cc: stable at vger.kernel.org # v3.11+
Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e25419817791..beba369d74de 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -898,7 +898,7 @@ config ARCH_MULTI_V5
>  	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
>  	depends on !ARCH_MULTI_V6_V7
>  	select ARCH_MULTI_V4_V5
> -	select CPU_ARM926T if (!CPU_ARM946E || CPU_ARM1020 || \
> +	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
>  		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
>  		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
>  
> -- 
> 1.8.5.3
> 
