From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 25 Jul 2011 17:11:55 +0530
Subject: [PATCH v2 0/3] Add device tree probe for imx-sdma driver
In-Reply-To: <20110722035450.GH26837@S2100-06.ap.freescale.net>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
	<20110722035450.GH26837@S2100-06.ap.freescale.net>
Message-ID: <1311594115.29703.23.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-22 at 11:54 +0800, Shawn Guo wrote:
> Hi Vinod,
> 
> Can I have your ack on this series, please?  I attempt to get it
> merged through Sascha's tree after his tree and devicetree/next get
> merged in the coming window.
> 
> Regards,
> Shawn
> 
> On Fri, Jul 15, 2011 at 05:44:23PM +0800, Shawn Guo wrote:
> > The first patch remove the use of software defined sdma version, and
> > instead uses platform_device_id to handle the sdma differences from
> > one soc to another.  The second one makes a small cleanup on function
> > sdma_get_firmware(), and the third patch adds the actual device tree
> > probe support.
> > 
> > Changes since v1:
> >  * Do not encode ROM script address in device tree
> >  * Add one more small cleanup on function sdma_get_firmware()
> > 
> > ShawnsGuo (3):
> >       dmaengine: imx-sdma: use platform_device_id to identify sdma version
> >       dmaengine: imx-sdma: sdma_get_firmware does not need to copy fw_name
> >       dmaengine: imx-sdma: add device tree probe support
> > 
> >  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   17 ++++
> >  arch/arm/mach-imx/clock-imx25.c                    |    3 +-
> >  arch/arm/mach-imx/clock-imx31.c                    |    2 +-
> >  arch/arm/mach-imx/clock-imx35.c                    |    2 +-
> >  arch/arm/mach-imx/mm-imx25.c                       |    4 +-
> >  arch/arm/mach-imx/mm-imx31.c                       |    3 +-
> >  arch/arm/mach-imx/mm-imx35.c                       |    3 +-
> >  arch/arm/mach-mx5/clock-mx51-mx53.c                |    6 +-
> >  arch/arm/mach-mx5/mm.c                             |    8 +-
> >  arch/arm/plat-mxc/devices/platform-imx-dma.c       |    4 +-
> >  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
> >  arch/arm/plat-mxc/include/mach/dma.h               |    3 +-
> >  arch/arm/plat-mxc/include/mach/sdma.h              |    2 -
> >  drivers/dma/imx-sdma.c                             |   92 +++++++++++++++-----
> >  14 files changed, 107 insertions(+), 44 deletions(-)
Acked-by: Vinod Koul <vinod.koul@intel.com>

I had queued this up for my tree, i am okay if it gets merged thru
Sascha

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
~Vinod Koul
Intel Corp.
