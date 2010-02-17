From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Feb 2010 21:18:01 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002171109.32107.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<201002171015.52875.oliver@neukum.org>
	<1266399609.16346.271.camel@pasglop>
	<201002171109.32107.oliver@neukum.org>
Message-ID: <1266401881.16346.278.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-17 at 11:09 +0100, Oliver Neukum wrote:
> 
> No problem here. USB core does the mapping only if the low-level driver
> so requests. The only exception is in usb_buffer_alloc(), but that boils
> down to dma_alloc_coherent() 

Allright, so why do we need to "fix" anything ? Or is the whole thread
moot ? :-)

It's pretty clear that between dma_map* and subsequent unmap, the memory
is owned by the device and must not be touched by the CPU. If that is
violated, then we have a driver bug.

Cheers,
Ben.
