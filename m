From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Sep 2011 00:56:29 -0700
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <4E7998AD.9070305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/20/2011 6:23 PM, Stephen Boyd wrote:
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6dbcb00..31896f4 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -81,6 +81,17 @@ choice
>  	prompt "Kernel low-level debugging port"
>  	depends on DEBUG_LL
>  
> +	config DEBUG_ICEDCC
> +		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
> +		depends on DEBUG_LL

Oops. This depends isn't necessary. Will fix before submitting to patch
tracker.

> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the EmbeddedICE macrocell's DCC channel using
> +		  co-processor 14. This is known to work on the ARM9 style ICE
> +		  channel and on the XScale with the PEEDI.
> +
> +		  It does include a timeout to ensure that the system does not
> +		  totally freeze when there is nothing connected to read.
>  
>  	config DEBUG_FOOTBRIDGE_COM1
>  		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
