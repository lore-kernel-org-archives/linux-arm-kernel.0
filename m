From: balbi@ti.com (Felipe Balbi)
Date: Wed, 21 Nov 2012 19:45:54 +0200
Subject: [PATCH 4/5] ARM: OMAP: Move plat-omap/dma-omap.h to
 include/linux/omap-dma.h
In-Reply-To: <20121121174233.25576.58781.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174233.25576.58781.stgit@muffinssi.local>
Message-ID: <20121121174554.GC13262@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 21, 2012 at 09:42:33AM -0800, Tony Lindgren wrote:
> Based on earlier discussions[1] we attempted to find a suitable
> location for the omap DMA header in commit 2b6c4e73 (ARM: OMAP:
> DMA: Move plat/dma.h to plat-omap/dma-omap.h) until the conversion
> to dmaengine is complete.
> 
> Unfortunately that was before I was able to try to test compile
> of the ARM multiplatform builds for omap2+, and the end result
> was not very good.
> 
> So I'm creating yet another all over the place patch to cut the
> last dependency for building omap2+ for ARM multiplatform. After
> this, we have finally removed the driver dependencies to the
> arch/arm code, except for few drivers that are being worked on.
> 
> The other option was to make the <plat-omap/dma-omap.h> path
> to work, but we'd have to add some new header directory to for
> multiplatform builds.
> 
> Or we would have to manually include arch/arm/plat-omap/include
> again from arch/arm/Makefile for omap2+.
> 
> Neither of these alternatives sound appealing as they will
> likely lead addition of various other headers exposed to the
> drivers, which we want to avoid for the multiplatform kernels.
> 
> Since we already have a minimal include/linux/omap-dma.h,
> let's just use that instead and add a note to it to not
> use the custom omap DMA functions any longer where possible.
> 
> Note that converting omap DMA to dmaengine depends on
> dmaengine supporting automatically incrementing the FIFO
> address at the device end, and converting all the remaining
> legacy drivers. So it's going to be few more merge windows.
> 
> [1] https://patchwork.kernel.org/patch/1519591/#
> 
> cc: Russell King <linux@arm.linux.org.uk>
> cc: Kevin Hilman <khilman@ti.com>
> cc: "Beno?t Cousson" <b-cousson@ti.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Vinod Koul <vinod.koul@intel.com>
> cc: Dan Williams <djbw@fb.com>
> cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> cc: David Woodhouse <dwmw2@infradead.org>
> cc: Kyungmin Park <kyungmin.park@samsung.com>
> cc: Felipe Balbi <balbi@ti.com>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> cc: Hans Verkuil <hans.verkuil@cisco.com>
> cc: Vaibhav Hiremath <hvaibhav@ti.com>
> cc: Lokesh Vutla <lokeshvutla@ti.com>
> cc: Rusty Russell <rusty@rustcorp.com.au>
> cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> cc: Afzal Mohammed <afzal@ti.com>
> cc: linux-crypto at vger.kernel.org
> cc: linux-media at vger.kernel.org
> cc: linux-mtd at lists.infradead.org
> cc: linux-usb at vger.kernel.org
> cc: linux-fbdev at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

...

>  drivers/usb/gadget/omap_udc.c                      |    2 
>  drivers/usb/musb/tusb6010_omap.c                   |    2 

for omap_udc and musb:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/fe5f9662/attachment.sig>
