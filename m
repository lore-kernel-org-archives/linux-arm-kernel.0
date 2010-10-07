From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 7 Oct 2010 10:22:13 +0200
Subject: [PATCHv4] ARM: imx: Add iram allocator functions
In-Reply-To: <1286383682-26506-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1286383682-26506-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <19629.33589.158235.949280@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]
> +void __iomem*iram_alloc(unsigned int size, unsigned long *dma_addr)
> +{
> +	if (!iram_pool)
> +		return NULL;
> +
> +	*dma_addr = gen_pool_alloc(iram_pool, size);
> +	pr_debug("iram alloc - %dB at 0x%p\n", size, (void *)*dma_addr);
why not:
| +	pr_debug("iram alloc - %dB at 0x08lx\n", size, *dma_addr);

> +	if (!dma_addr)
>
This will never be true (unless someone passes a NULL pointer as
dma_addr).
| +	if (!*dma_addr)
was obviously meant here.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
