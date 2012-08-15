From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 15:23:21 +0000
Subject: [PATCH v2 27/31] arm64: Loadable modules
In-Reply-To: <1344966752-16102-28-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-28-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151523.21447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> +
> +void *module_alloc(unsigned long size)
> +{
> +       return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +                                   GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
> +                                   __builtin_return_address(0));
> +}
> +

What is the reason for using a separate virtual address range for the
modules instead of falling back to the default module_alloc function
that uses vmalloc_exec()?

	Arnd
