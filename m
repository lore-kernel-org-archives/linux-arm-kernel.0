From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Feb 2013 23:10:04 -0500 (EST)
Subject: [PATCH 01/17] ARM: add CPU_BE8_BOOT_LE configuration
In-Reply-To: <1360365467-25056-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1302082228160.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Feb 2013, Ben Dooks wrote:

> Add configuration for booting a BE8 system from a LE boot environment.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mm/Kconfig |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 3fd629d..70e2ad9 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -688,6 +688,13 @@ config CPU_ENDIAN_BE8
>  	help
>  	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
>  
> +config CPU_BE8_BOOT_LE
> +	bool "Boot BE system from LE loader"
> +	depends on CPU_ENDIAN_BE8
> +	help
> +	  Support for running BE-8 (big-endian) from a boot environment that is
> +	  running in LE mode.
> +

This looks strange to have a patch that only adds a config symbol with 
no user.  Could you move it later in the series, or fold it with, say, 
patch #4?






>  config CPU_ENDIAN_BE32
>  	bool
>  	depends on CPU_BIG_ENDIAN
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
