From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 16 Nov 2016 13:23:29 -0700
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <alpine.DEB.2.20.1611160939140.3364@atull-VirtualBox2>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
 <20161114001854.GA27248@obsidianresearch.com>
 <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
 <20161115043537.GA23253@obsidianresearch.com>
 <alpine.DEB.2.20.1611150940270.3634@atull-VirtualBox2>
 <20161116052033.GA6044@obsidianresearch.com>
 <alpine.DEB.2.20.1611160939140.3364@atull-VirtualBox2>
Message-ID: <20161116202329.GD19593@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 09:45:23AM -0600, atull wrote:
> > What is the point of this if write_init gets a copy of the buffer -
> > what is that supposed to be?
> 
> Sometimes write_init needs to look at the header of the image.
> You can see that in the socfpga-a10.c (on linux-next/master)

I know what it is for, I'm asking what should it be if we are calling
write_init multiple times.

It feels like the driver needs to indicate the header length it wants
to inspect and the core core needs to make that much of the bitstream
available to write_init() before calling write().

Is that what you were thinking?

> at this stuff, this is coming at a busy time).  My point there
> was that there was code that needed to go into the core so that
> the ICE40 and the cyclone spi driver that are on the mailing
> list won't have to have the same workaround that you were
> adding to the socfpga.c driver.

Sure, that is easy for write() - not clear on write_init sematics?
I will send a revised series.

I'd also like to close on the zynq bitfile verification patch, did you
have any comments on that?

Jason
