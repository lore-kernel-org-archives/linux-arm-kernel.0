From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 7 Apr 2014 20:02:28 +0200
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <20140407171012.GC9952@obsidianresearch.com>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
 <53423E75.3020008@monstr.eu> <53429754.8080105@topic.nl>
 <534298E7.2020409@monstr.eu>
 <20140407171012.GC9952@obsidianresearch.com>
Message-ID: <20140407180228.GN12170@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Apr 07, 2014 at 11:10:12AM -0600, Jason Gunthorpe wrote:
> On Mon, Apr 07, 2014 at 02:24:07PM +0200, Michal Simek wrote:
> 
> > Device-tree BSP and in 2014.01 there will be new BSP which just
> > generate them directly from the Vivado tools which just target your
> > reference design.  You can connect your custom IP (or Xilinx or 3rd
> > party) directly to the GIC which using different IRQ sensitivity
> > with whatever register addresses and make no sense to write it by
> > hand.
> 
> On our Zynq design here we ended up being unwilling to use platform
> generation from Vivado. Basically all our IP was custom, so there was
> no win at all to invoking the complexity of the automatic tools.
> 
> Thus we write the DT by hand, and our DT is complex, integrating
> peripherals that span two FPGAs.
> 
> I think the in-kernel DT should use the kernel conventions, which
> means using #include and the binding constants over magic values.
> 

ACK.

If in doubt follow common mainline practice. Although using includes
for DT is not necessarily common practice, readability of DTs is
really important IMHO.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
