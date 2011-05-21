From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 May 2011 00:35:58 +0100
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
Message-ID: <20110521233558.GA17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 09:08:17AM -0700, Stephen Neuendorffer wrote:
> > That is how it is currently, but the reality is that I only have 1 bus
> > with both ARM Primecell peripherals and other peripherals which are
> > standard platform bus devices. i2c-designware is one example. It is on
> > the APB just like the pl011 uart. So do you propose I create a amba
> > driver for it? It has no peripheral ID registers, so that may not even
> work.
> 
> Same here.  I don't know what the right solution for it is, but I find
> amba_bus
> solution to get in the way more than help.  I had to hack the etm/etb
> driver
> and the amba_bus to shreds to get it to work for me at all.

Well then you're doing something totally wrong then.  All you need to
do to get an amba_device working is provide an apb_clk as a dummy clock
if you have no control over it, and declare an amba_device structure
with the relevant physical base addresses and irq.  There's no need to
hack anything "to shreds" to get it work work - there's nothing platform
specific in drivers/bus/amba.c.

That is proven by it being used on several ARM dev platforms and several
ST Ericsson SoCs - and it's actually ST Ericsson driving the addition of
the various new features to the bus level of AMBA.

So I think you're doing something wrong, rather than there being anything
wrong with the code.
