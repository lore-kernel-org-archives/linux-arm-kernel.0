From: oliver@neukum.org (Oliver Neukum)
Date: Tue, 16 Feb 2010 10:07:20 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7DBB@dbde02.ent.ti.com>
References: <20100208065519.GE1290@ucw.cz>
	<201002160922.47072.oliver@neukum.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7DBB@dbde02.ent.ti.com>
Message-ID: <201002161007.20576.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Februar 2010 09:55:55 schrieb Shilimkar, Santosh:
> > This seems wrong to me. Buffers for control transfers may be transfered
> > by DMA, so the caches must be flushed on architectures whose caches
> > are not coherent with respect to DMA.
> Indeed and that's what I mentioned in the comment. But we shouldn't have dma 
> cache maintenance operations done for the buffers which would use pio based transfer.

Given that the generic layer can't know which buffers will be used for DMA
that would require a callback into the hcd driver.

> > Would you care to elaborate on the exact nature of the bug you are fixing?
> On the OMAP4 (ARM cortex-a9) platform, the enumeration fails because control
> transfer buffers are corrupted. On our platform, we use PIO mode for control 
> transfers and DMA for bulk transfers.
> 
> The current stack performs dma cache maintenance even for the PIO transfers
> which leads to the corruption issue. The control buffers are handled by CPU 
> and they already coherent from CPU point of view.

How does the mapping corrupt buffers? It might impact performance, but why
do you see corruption?

	Regards
		Oliver
