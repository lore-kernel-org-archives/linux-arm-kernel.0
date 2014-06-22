From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Jun 2014 14:23:15 +0200
Subject: [PATCH v3 1/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <53A6C4D0.1030102@gmail.com>
References: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
 <201406142101.02747.marex@denx.de> <53A6C4D0.1030102@gmail.com>
Message-ID: <201406221423.15193.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 22, 2014 at 01:58:08 PM, Corentin LABBE wrote:
[...]
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation version 2 of the License
> > 
> > The license text seems incomplete.
> > [...]
> 
> I will replace it with a simplier line "Licensed under the GPL-2."

I'd suggest you to use the SPDX license identifiers then, but that's not 
something the kernel crowd agreed upon yet IIRC.Therefore , just make the text 
complete please.

[...]

> >> +	src_addr = kmap(sg_page(in_sg)) + in_sg->offset;
> >> +	if (src_addr == NULL) {
> >> +		dev_err(ss->dev, "KMAP error for src SG\n");
> >> +		return -1;
> >> +	}
> > 
> > Why can't you just use dma_map_sg() or somesuch ?
> 
> I do not see why I will use a DMA function in a driver without DMA support.
> Perhaps I do not know some tricks.
> Can I use writel/readl on address gived by DMA API ?

Oh, ok, good question -- dear list, shall one use sg_page()+kmap or sg_virt()?

btw. I just noticed you're just feeding the hardware FIFO in a loop with data in 
the scatterlists, do I understand it correctly ? The driver will consume quite a 
lot of CPU time to do that, can you not implement DMA here ?

[...]

Best regards,
Marek Vasut
