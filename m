From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 17 Feb 2010 11:23:30 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266401881.16346.278.camel@pasglop>
References: <20100208065519.GE1290@ucw.cz>
	<201002171109.32107.oliver@neukum.org>
	<1266401881.16346.278.camel@pasglop>
Message-ID: <201002171123.30389.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Februar 2010 11:18:01 schrieb Benjamin Herrenschmidt:
> > No problem here. USB core does the mapping only if the low-level driver
> > so requests. The only exception is in usb_buffer_alloc(), but that boils
> > down to dma_alloc_coherent() 
> 
> Allright, so why do we need to "fix" anything ? Or is the whole thread
> moot ? :-)

The request a low-level driver does is all or nothing. Either DMA
issues have to be handled by that driver alone, or a finer-grained
description of the DMA requirements is needed. A fix using the latter
approach is being worked on.

	Regards
		Oliver
