From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jun 2014 10:29:13 +0100
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140602092913.GA933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 11:21:02AM +0200, Antoine T?nart wrote:
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index d3c5f14dc142..e3733692f67a 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -4,6 +4,7 @@ config ARCH_BERLIN
>  	select GENERIC_IRQ_CHIP
>  	select DW_APB_ICTL
>  	select DW_APB_TIMER_OF
> +	select SMP

Please don't add selects of symbols which aren't absolutely necessary.

Since this has been merged without SMP support and presumably works without
SMP support, it would appear that SMP support is not mandatory for the
platform to work.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
