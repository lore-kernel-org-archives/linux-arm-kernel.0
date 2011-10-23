From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2011 13:00:08 +0100
Subject: [PATCH v7 16/16] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <1312988619-16804-17-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-17-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111023120008.GE17912@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:39PM +0100, Catalin Marinas wrote:
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 88633fe..2df5504 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -629,6 +629,19 @@ config IO_36
>  
>  comment "Processor Features"
>  
> +config ARM_LPAE
> +	bool "Support for the Large Physical Address Extension"
> +	depends on MMU && CPU_V7
> +	help
> +	  Say Y if you have an ARMv7 processor supporting the LPAE page table
> +	  format and you would like to access memory beyond the 4GB limit.

This help text is entirely insufficient.  It doesn't tell people what the
implications are for enabling this option on CPUs without LPAE support.
(It won't boot.)  It doesn't suggest what people should select when they're
unsure what setting to use.
