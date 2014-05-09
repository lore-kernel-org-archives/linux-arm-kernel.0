From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 09 May 2014 10:20:08 +0200
Subject: [PATCH v6 3/4] usb: ohci-exynos: Add facility to use phy provided
 by the generic phy framework
In-Reply-To: <1399266177-31765-1-git-send-email-gautam.vivek@samsung.com>
References: <5363D835.7010804@gmail.com>
 <1399266177-31765-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <536C8FB8.7020806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 05.05.2014 07:02, Vivek Gautam wrote:
> Add support to consume phy provided by Generic phy framework.
> Keeping the support for older usb-phy intact right now, in order
> to prevent any functionality break in absence of relevant
> device tree side change for ohci-exynos.
> Once we move to new phy in the device nodes for ohci, we can
> remove the support for older phys.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> 
> Changes from v5:
>  - Removed setting phy explicitly to error pointer.
>  - Changed error check to '-ENOSYS' instead of '-ENXIO' in failure case of
>    devm_of_phy_get().
> 
> Changes from v4:
>  - Removed 'phy-names' property from the bindings since we don't need it.
>  - Restructured exynos_ohci_get_phy() function to handle error codes as
>    well as return relevant error codes effectively.
>  - Added IS_ERR() check for PHYs in exynos_ohci_phy_enable()/disable().
> 
> Changes from v3:
>  - Calling usb_phy_shutdown() when exynos_ohci_phy_enable() is failing.
>  - Made exynos_ohci_phy_disable() return void, since its return value
>    did not serve any purpose.
>  - Calling clk_disable_unprepare() in exynos_ohci_resume() when
>    exynos_ohci_phy_enable() is failed.
> 
>  .../devicetree/bindings/usb/exynos-usb.txt         |   16 +++
>  drivers/usb/host/ohci-exynos.c                     |  118 +++++++++++++++++---
>  2 files changed, 118 insertions(+), 16 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
