From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Feb 2010 20:26:17 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <Pine.LNX.4.44L0.1002171201190.1913-100000@iolanthe.rowland.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF84D1@dbde02.ent.ti.com>
	<Pine.LNX.4.44L0.1002171201190.1913-100000@iolanthe.rowland.org>
Message-ID: <20100217202617.GB30033@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 12:02:21PM -0500, Alan Stern wrote:
> Why do you skip mapping the setup packet but not the data packet?

This is something of a FAQ in this thread.  Here are the responses to
similar questions yesterday:

"Gadiyar, Anand" <gadiyar@ti.com> said:
> Not really. For instance, in the case of the DMA engine in the MUSB
> controller in OMAP3, we can only use DMA with endpoints other than
> EP0, and EP0 is what is used for control transfers.
>
> It's not PIO for all the endpoints or DMA for all of them.

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> said:
> On the OMAP4 (ARM cortex-a9) platform, the enumeration fails because control
> transfer buffers are corrupted. On our platform, we use PIO mode for control
> transfers and DMA for bulk transfers.
>
> The current stack performs dma cache maintenance even for the PIO transfers
> which leads to the corruption issue. The control buffers are handled by CPU
> and they already coherent from CPU point of view.
