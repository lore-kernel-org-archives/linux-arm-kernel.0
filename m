From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 11 Jun 2010 10:58:07 -0700
Subject: [PATCH] ARM: Add ARCH_HAS_L2X0 and make CACHE_L2X0 config
	depend on that
In-Reply-To: <1276272211-13065-1-git-send-email-olof@lixom.net>
References: <6fqujhaev78923q90va>
	<1276272211-13065-1-git-send-email-olof@lixom.net>
Message-ID: <1276279087.31800.6.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-06-11 at 11:03 -0500, Olof Johansson wrote:

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 346ae14..419b957 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -759,11 +759,13 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
>  	  Say Y here to use the Feroceon L2 cache in writethrough mode.
>  	  Unless you specifically require this, say N for writeback mode.
>  
> +config ARCH_HAS_L2X0
> +	bool
> +	default n
> +

I made a similar change not too long ago, but Russell wanted the define
to be HAVE_CACHE_L2X0 ..

Daniel
