From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Apr 2012 11:12:44 +0100
Subject: [PATCH/RESEND] ARM: Kconfig: Remove duplicate IRQ Kconfig entries
In-Reply-To: <1333992911-26744-1-git-send-email-sboyd@codeaurora.org>
References: <1333992911-26744-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120410101244.GR24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Who are you expecting to pick up on this patch?  You're sending it _to_
the mailing list rather than to a person.  Are you expecting all
subscribers to pick it up and apply it individually? ;)

On Mon, Apr 09, 2012 at 10:35:11AM -0700, Stephen Boyd wrote:
> These kconfig entries are already defined in kernel/irq/Kconfig
> so select them instead of redefining them.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/Kconfig |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7a08e37..a3ae6e9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -30,6 +30,8 @@ config ARM
>  	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
>  	select HAVE_C_RECORDMCOUNT
>  	select HAVE_GENERIC_HARDIRQS
> +	select HARDIRQS_SW_RESEND
> +	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select CPU_PM if (SUSPEND || CPU_IDLE)
>  	select GENERIC_PCI_IOMAP
> @@ -125,14 +127,6 @@ config TRACE_IRQFLAGS_SUPPORT
>  	bool
>  	default y
>  
> -config HARDIRQS_SW_RESEND
> -	bool
> -	default y
> -
> -config GENERIC_IRQ_PROBE
> -	bool
> -	default y
> -
>  config GENERIC_LOCKBREAK
>  	bool
>  	default y
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
