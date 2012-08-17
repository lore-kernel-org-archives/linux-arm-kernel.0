From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:19:08 -0700
Subject: [PATCH v2 13/31] arm64: Device specific operations
In-Reply-To: <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817091908.GQ11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:05]:
> --- /dev/null
> +++ b/arch/arm64/mm/ioremap.c
> +
> +void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
> +{
> +	return __ioremap_caller(phys_addr, size, prot,
> +				__builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(__ioremap);

>From SoC point of view, we're probably going to need __ioremap_exec()
here too for programming clocks during runtime in SRAM etc. But that
can be added later as needed.

Acked-by: Tony Lindgren <tony@atomide.com>
