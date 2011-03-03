From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Mar 2011 19:15:55 +0100
Subject: [PATCH v9 1/1] PRUSS UIO driver support
In-Reply-To: <1299175677-17859-2-git-send-email-pratheesh@ti.com>
References: <1299175677-17859-1-git-send-email-pratheesh@ti.com>
	<1299175677-17859-2-git-send-email-pratheesh@ti.com>
Message-ID: <201103031915.55825.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2011 19:07:57 Pratheesh Gangadhar wrote:
> +struct uio_pruss_dev {
> +       struct uio_info *info;
> +       struct clk *pruss_clk;
> +       dma_addr_t sram_paddr;
> +       dma_addr_t ddr_paddr;
> +       void __iomem *prussio_vaddr;
> +       void *sram_vaddr;
> +       void *ddr_vaddr;
> +       unsigned int hostirq_start;
> +       unsigned int pintc_base;
> +};
> +
> +struct pruss_priv {
> +       struct uio_pruss_dev *pupdev;
> +};

I cannot see the point of struct pruss_priv, I think it would be better to
just merge the two data structures into one. Everything else looks
good to me now.

	Arnd
