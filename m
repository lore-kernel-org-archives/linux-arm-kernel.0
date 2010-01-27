From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 21:34:53 +0000
Subject: [PATCH 2/2] ARM: S3C: Configuration override for UART names
In-Reply-To: <1264610289-14412-2-git-send-email-buserror@gmail.com>
References: <1264610289-14412-1-git-send-email-buserror@gmail.com>
	<1264610289-14412-2-git-send-email-buserror@gmail.com>
Message-ID: <20100127213453.GA29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 04:38:09PM +0000, Michel Pollet wrote:
> diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
> index 9e9d028..158257a 100644
> --- a/arch/arm/plat-s3c/Kconfig
> +++ b/arch/arm/plat-s3c/Kconfig
> @@ -113,6 +113,15 @@ config S3C_LOWLEVEL_UART_PORT
>  	  this configuration should be between zero and two. The port
>  	  must have been initialised by the boot-loader before use.
>  
> +config S3C_STD_UART_NAMES
> +	bool "Name S3C UART device files as ttySACx"
> +	default n

default n is the default default.  There's no need to explicitly specify
a default default.
