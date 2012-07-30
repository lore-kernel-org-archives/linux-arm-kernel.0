From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2012 15:16:17 +0100
Subject: [PATCH 10/11] ARM: versatile: Make able to use UART ports for
 KGDB FIQ debugger
In-Reply-To: <1343649500-18491-10-git-send-email-anton.vorontsov@linaro.org>
References: <20120730115719.GA5742@lizard>
 <1343649500-18491-10-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <20120730141617.GK6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:58:19AM -0700, Anton Vorontsov wrote:
> diff --git a/arch/arm/mach-versatile/include/mach/irqs.h b/arch/arm/mach-versatile/include/mach/irqs.h
> index bf44c61..fcd2a95 100644
> --- a/arch/arm/mach-versatile/include/mach/irqs.h
> +++ b/arch/arm/mach-versatile/include/mach/irqs.h
> @@ -26,6 +26,7 @@
>   *  held within platform.h
>   */
>  #define IRQ_VIC_START		0
> +#define FIQ_START		IRQ_VIC_START

No.  We want to ultimately get rid of FIQ_START.
