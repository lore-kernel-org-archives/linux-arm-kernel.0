From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 8 Oct 2010 15:53:31 +0200
Subject: [PATCHv6] ARM: imx: Add iram allocator functions
In-Reply-To: <1286545333-30323-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1286545333-30323-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <19631.8795.122477.334402@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dinh.Nguyen at freescale.com writes:
[...]
> +void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
> +{
> +	if (!iram_pool)
> +		return NULL;
> +
> +	*dma_addr = gen_pool_alloc(iram_pool, size);
> +	pr_debug("iram alloc - %dB at 0x%p\n", size, (void *)*dma_addr);
                                                  ^^^^^^^^
Is there any reason to insist on this silly type cast instead of using
the format string that fits the data type?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
