From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 28 Oct 2016 09:48:19 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <7950dec2-cc69-6304-ea2d-92b1a890214e@suse.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <7950dec2-cc69-6304-ea2d-92b1a890214e@suse.com>
Message-ID: <20161028154819.GD10441@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 01:12:06PM +0200, Matthias Brugger wrote:
> >Zynq is also only able to DMA dword quantities, so bitstreams must be
> >a multiple of 4 bytes. This also fixes a DMA-past the end bug.
> 
> The you can also fix the transfer_length calculation in zynq_fpga_ops_write,
> as we don't allow buffers which are not a multiple of 4.

Didn't I do that? Did you see something else to change in the dma
part?

Jason
