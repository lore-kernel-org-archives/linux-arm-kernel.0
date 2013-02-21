From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Feb 2013 16:28:21 -0700
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <20130221231848.880DE200552@gemini.denx.de>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk>
 <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
 <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
 <20130221231848.880DE200552@gemini.denx.de>
Message-ID: <20130221232821.GA2823@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 12:18:48AM +0100, Wolfgang Denk wrote:

> > The DT is meant to describe hardware.  As far as I know, the hardware I 
> > own seems to be rather static and stable, and unlike software there is 
> > no way I can change it (soldering irons don't count).
> 
> There is other hardware available (for example FPGA based) where this
> does not apply.

Agreed.. We do that here as well, the DT is also used to describe the
functionality inside FPGA(s). We do things like declare a GPIO
controller inside the FPGA, then stack the bitbang MDIO/I2C on top of
that, then declare a bunch of devices on those busses. DT makes this
extremely straightforward.

However, it is critical that the DT, kernel and FPGA are matched
together - we always arrange things so that the DTB, kernel and FPGA
config are bundled together and update atomically during firmware
upgrade.

Xilinx's Zynq is a great example of this kind of stuff, FWIW. IIRC
Xilinx has a DT generator from their IP tools, so you can literally go
into their design software, configure the hardware IP blocks, and get
back a FPGA config and a DT to go with it.

Jason
