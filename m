From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 09:29:32 +0530
Subject: [PATCH v2 0/3] Add device tree probe for imx-sdma driver
In-Reply-To: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1312430372.1536.554.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-15 at 17:44 +0800, Shawn Guo wrote:
> The first patch remove the use of software defined sdma version, and
> instead uses platform_device_id to handle the sdma differences from
> one soc to another.  The second one makes a small cleanup on function
> sdma_get_firmware(), and the third patch adds the actual device tree
> probe support.
> 
> Changes since v1:
>  * Do not encode ROM script address in device tree
>  * Add one more small cleanup on function sdma_get_firmware()
> 
> ShawnsGuo (3):
>       dmaengine: imx-sdma: use platform_device_id to identify sdma version
>       dmaengine: imx-sdma: sdma_get_firmware does not need to copy fw_name
>       dmaengine: imx-sdma: add device tree probe support
> 
Sacha are you okay if this go via my tree, would need your ack before I
take this one

>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   17 ++++
>  arch/arm/mach-imx/clock-imx25.c                    |    3 +-
>  arch/arm/mach-imx/clock-imx31.c                    |    2 +-
>  arch/arm/mach-imx/clock-imx35.c                    |    2 +-
>  arch/arm/mach-imx/mm-imx25.c                       |    4 +-
>  arch/arm/mach-imx/mm-imx31.c                       |    3 +-
>  arch/arm/mach-imx/mm-imx35.c                       |    3 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c                |    6 +-
>  arch/arm/mach-mx5/mm.c                             |    8 +-
>  arch/arm/plat-mxc/devices/platform-imx-dma.c       |    4 +-
>  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
>  arch/arm/plat-mxc/include/mach/dma.h               |    3 +-
>  arch/arm/plat-mxc/include/mach/sdma.h              |    2 -
>  drivers/dma/imx-sdma.c                             |   92 +++++++++++++++-----
>  14 files changed, 107 insertions(+), 44 deletions(-)


-- 
~Vinod
