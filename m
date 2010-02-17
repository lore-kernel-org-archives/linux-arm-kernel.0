From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 17 Feb 2010 11:09:31 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266399609.16346.271.camel@pasglop>
References: <20100208065519.GE1290@ucw.cz>
	<201002171015.52875.oliver@neukum.org>
	<1266399609.16346.271.camel@pasglop>
Message-ID: <201002171109.32107.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Februar 2010 10:40:09 schrieb Benjamin Herrenschmidt:
> What bugs me here is that the dma_map_* operation should always
> be done at the lowest level, ie, the actual HCD driver, and thus
> it should be up to the HCD to decide whether to dma_map or not
> depending on whether it's going to do DMA or not. I haven't
> scrutinized USB lately but if that isn't the case and the dma_map_*
> operations are done behind your back by the USB core then that needs to
> be changed in a way or another, or hooked at least.

No problem here. USB core does the mapping only if the low-level driver
so requests. The only exception is in usb_buffer_alloc(), but that boils
down to dma_alloc_coherent()

	Regards
		Oliver
