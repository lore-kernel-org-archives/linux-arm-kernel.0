From: oliver@neukum.org (Oliver Neukum)
Date: Tue, 16 Feb 2010 09:22:47 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
Message-ID: <201002160922.47072.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Februar 2010 08:57:53 schrieb Shilimkar, Santosh:
> Continuing on the USB issue w.r.t cache coherency, the usb host
> code is violating the buffer ownership rules of streaming APIs from
> dma and non-dma transfers point if view.
> 
> We have a below temporary patch to get around the issue and probably it
> needs to be fixed in the right way in the stack because some controllers
> may not have PIO option even for control transfers. (e.g. Synopsis EHCI
> controller)

This seems wrong to me. Buffers for control transfers may be transfered
by DMA, so the caches must be flushed on architectures whose caches
are not coherent with respect to DMA.

Would you care to elaborate on the exact nature of the bug you are fixing?

	Regards
		Oliver
