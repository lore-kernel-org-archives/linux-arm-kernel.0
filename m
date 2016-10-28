From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 28 Oct 2016 13:12:06 +0200
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161026225413.GA6220@obsidianresearch.com>
References: <20161026225413.GA6220@obsidianresearch.com>
Message-ID: <7950dec2-cc69-6304-ea2d-92b1a890214e@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/27/2016 12:54 AM, Jason Gunthorpe wrote:
> There is no sense in sending a bitstream we know will not work, and
> with the variety of options for bitstream generation in Xilinx tools
> it is not terribly clear or very well documented what the correct
> input should be, especially since auto-detection was removed from this
> driver.
>
> All Zynq full configuration bitstreams must start with the sync word in
> the correct byte order.
>
> Zynq is also only able to DMA dword quantities, so bitstreams must be
> a multiple of 4 bytes. This also fixes a DMA-past the end bug.
>

The you can also fix the transfer_length calculation in 
zynq_fpga_ops_write, as we don't allow buffers which are not a multiple 
of 4.

Regards,
Matthias
