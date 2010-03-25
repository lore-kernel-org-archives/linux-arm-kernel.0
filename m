From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 20:32:42 +0000
Subject: [PATCH 2/7 v2] Add clock framework for plat-tcc
In-Reply-To: <20100325200915.GE2047@bluebox.local>
References: <20100325200427.GC2047@bluebox.local>
	<20100325200915.GE2047@bluebox.local>
Message-ID: <20100325203242.GC24984@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 09:09:16PM +0100, Hans J. Koch wrote:
> +#define BCLKCTR0	(void __iomem *)(CKC_BASE + BCLKCTR0_OFFS)
> +#define BCLKCTR1	(void __iomem *)(CKC_BASE + BCLKCTR1_OFFS)

If you define CKC_BASE to have type 'void __iomem *' then all these
cases go away.

> +	reg = __raw_readl(CKC_BASE + CLKCTRL_OFFS);

And this won't warn in the future.
