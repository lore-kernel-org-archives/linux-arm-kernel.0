From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2011 09:12:42 +0100
Subject: [PATCH v3] pxa2xx_spi: fix memory corruption
In-Reply-To: <20110715025331.GL2927@ponder.secretlab.ca>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
Message-ID: <20110715081242.GM23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 08:53:31PM -0600, Grant Likely wrote:
> > +	u8 null_dma_buf_unaligned[16];
> 
> Don't dma buffers need to be cache-line aligned?  How large is the
> actual transfer?  Using the __aligned() or __cacheline_aligned
> attribute is the correct way to make sure you've got a data buffer
> that can be used for DMA mixed with other stuff.  Then you don't need
> to fool around with PTR_ALIGN or anything.

Err, did you not read the whole patch?

> > +	drv_data->null_dma_buf =
> > +		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);
