From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Apr 2014 11:10:12 -0600
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <534298E7.2020409@monstr.eu>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
 <53423E75.3020008@monstr.eu> <53429754.8080105@topic.nl>
 <534298E7.2020409@monstr.eu>
Message-ID: <20140407171012.GC9952@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 02:24:07PM +0200, Michal Simek wrote:

> Device-tree BSP and in 2014.01 there will be new BSP which just
> generate them directly from the Vivado tools which just target your
> reference design.  You can connect your custom IP (or Xilinx or 3rd
> party) directly to the GIC which using different IRQ sensitivity
> with whatever register addresses and make no sense to write it by
> hand.

On our Zynq design here we ended up being unwilling to use platform
generation from Vivado. Basically all our IP was custom, so there was
no win at all to invoking the complexity of the automatic tools.

Thus we write the DT by hand, and our DT is complex, integrating
peripherals that span two FPGAs.

I think the in-kernel DT should use the kernel conventions, which
means using #include and the binding constants over magic values.

Jason
