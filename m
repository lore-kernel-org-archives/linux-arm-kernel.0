From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jul 2010 18:08:01 +0200
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <20100709110801.11333.22995.stgit@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110801.11333.22995.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <201007091808.01536.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010, Catalin Marinas wrote:
> This patch introduces readl*_relaxed()/write*_relaxed() as the main I/O
> accessors (when __mem_pci is defined). The standard read*()/write*()
> macros are now based on the relaxed accessors.

Are these new macros valid for both PCI and non-PCI mmio addresses?
The way I understand it, the regular readl/writel family is only
valid for __iomem addresses in PCI BARs, while anything else
has to go through either ioread32/iowrite32 or something arch
specific.

Does this mean we also need an ioread32_releaxed etc?

	Arnd
