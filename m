From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Oct 2010 09:30:45 +0100
Subject: [PATCH] ARM: Fix data abort accessing proc_info from
	__lookup_processor_type (Re: [PATCH 03/10] ARM: hotplug cpu: Keep
	processor information, startup code & __lookup_processor_type)
In-Reply-To: <20101022185108.GF17595@atomide.com>
References: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk>
	<20101022185108.GF17595@atomide.com>
Message-ID: <20101023083044.GA13009@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 22, 2010 at 11:51:08AM -0700, Tony Lindgren wrote:
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 1953e3d..a58b91d 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -114,6 +114,7 @@ SECTIONS
>  			*(.glue_7)
>  			*(.glue_7t)
>  		*(.got)			/* Global offset table		*/
> +			. = ALIGN(4);
>  			ARM_CPU_KEEP(PROC_INFO)

The got table should also be word aligned - but the kernel doesn't use
one.  In any case, it would be a good idea to place it before the .got.
