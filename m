From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Mar 2011 14:22:26 +0100
Subject: [PATCH v8 1/1] PRUSS UIO driver support
In-Reply-To: <1299065886-30099-2-git-send-email-pratheesh@ti.com>
References: <1299065886-30099-1-git-send-email-pratheesh@ti.com>
	<1299065886-30099-2-git-send-email-pratheesh@ti.com>
Message-ID: <201103021422.27094.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2011, Pratheesh Gangadhar wrote:
> +
> +static struct clk *pruss_clk;
> +static struct uio_info *info;
> +static dma_addr_t sram_paddr, ddr_paddr;
> +static void *prussio_vaddr, *sram_vaddr, *ddr_vaddr;
> +

To my initial comment about these being single-instance
variables, you said you'd change that, which has not happened
yet.

Also, I now noticed that the types are wrong, you are
missing __iomem annotations for MMIO ranges. Please make
sure that the code builds fine with sparse and "make C=1",
which will tell you about these problems.

	Arnd
