From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 9 Nov 2016 21:58:49 -0700
Subject: [PATCH fpga 2/9] fpga zynq: Check the bitstream for validity
In-Reply-To: <17912798-e55d-253f-42fc-c7287d067e00@gmail.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-3-git-send-email-jgunthorpe@obsidianresearch.com>
 <17912798-e55d-253f-42fc-c7287d067e00@gmail.com>
Message-ID: <20161110045849.GA22004@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 04:04:07PM -0800, Joshua Clayton wrote:

> > +		if (!zynq_fpga_has_sync(buf, count)) {
> > +			dev_err(priv->dev,
> > +				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swaped .bin file\n");
> Nitpick: byte swaped is a misspelling...

oops, sure.

> and I'm not sure I like the second half of this message.  Maybe
> something like "Bitstream must be lsb first" (if that is what is
> meant).

I intended it to be a recipe to follow, not a specification. It
literally means take the .bin file and dword byte swap it to make it
work with the driver.

Describing it as LSB first would be consistent with UG470, but I doubt
many people know Xilinx tools emit the bitstream in 32 bit MSB format
and probably even fewer people know that the relavent difference
between .bit and .bin boils down to the alignment of the sync word -
which is why I prefered the recipe style..

Jason
