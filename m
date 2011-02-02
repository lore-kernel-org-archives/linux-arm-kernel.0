From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Feb 2011 12:20:26 -0800
Subject: [PATCH 2/2] arm: Kconfig: allow OMAP to use sparse IRQ numbering
In-Reply-To: <1296664315-32108-3-git-send-email-balbi@ti.com>
References: <1296664315-32108-1-git-send-email-balbi@ti.com>
	<1296664315-32108-3-git-send-email-balbi@ti.com>
Message-ID: <20110202202026.GH3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110202 08:31]:
> Select HAVE_SPARSE_IRQ to allow OMAP to use
> sparse IRQ numbering scheme. The main difference
> is that irq_descs will be added to a radix tree
> instead of a static array.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Assuming these two will go through Russell's tree:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 09a5c11..2ca24ad 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -857,6 +857,7 @@ config ARCH_DAVINCI
>  config ARCH_OMAP
>  	bool "TI OMAP"
>  	select HAVE_CLK
> +	select HAVE_SPARSE_IRQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_CPUFREQ
>  	select GENERIC_CLOCKEVENTS
> -- 
> 1.7.4.rc2
> 
