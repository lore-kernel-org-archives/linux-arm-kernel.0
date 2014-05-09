From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 09 May 2014 10:19:51 +0200
Subject: [PATCH v12 4/4] usb: ehci-exynos: Change to use phy provided by
 the generic phy framework
In-Reply-To: <1399266148-31729-1-git-send-email-gautam.vivek@samsung.com>
References: <1399034855-9686-5-git-send-email-gautam.vivek@samsung.com>
 <1399266148-31729-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <536C8FA7.2040401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 05.05.2014 07:02, Vivek Gautam wrote:
> From: Kamil Debski <k.debski@samsung.com>
> 
> Add the phy provider, supplied by new Exynos-usb2phy using
> Generic phy framework.
> Keeping the support for older USB phy intact right now, in order
> to prevent any functionality break in absence of relevant
> device tree side change for ehci-exynos.
> Once we move to new phy in the device nodes for ehci, we can
> remove the support for older phys.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> [gautam.vivek at samsung.com: Addressed review comments from mailing list]
> [gautam.vivek at samsung.com: Kept the code for old usb-phy, and just
> added support for new exynos5-usb2phy in generic phy framework]
> [gautam.vivek at samsung.com: Edited the commit message]
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> 
> Changes from v11:
>  - Removed setting phy explicitly to error pointer.
>  - Changed error check to '-ENOSYS' instead of '-ENXIO' in failure case of
>    devm_of_phy_get().
> 
> Changes from v10:
>  - Removed 'phy-names' property from the bindings since we don't need it.
>  - Restructured exynos_ehci_get_phy() function to handle error codes as
>    well as return relevant error codes effectively.
>  - Added IS_ERR() check for PHYs in exynos_ehci_phy_enable()/disable().
> 
> Changes from v9:
>  - Calling usb_phy_shutdown() when exynos_ehci_phy_enable() is failing.
>  - Made exynos_ehci_phy_disable() return void, since its return value
>    did not serve any purpose.
>  - Calling clk_disable_unprepare() in exynos_ehci_resume() when
>    exynos_ehci_phy_enable() is failed.
> 
>  .../devicetree/bindings/usb/exynos-usb.txt         |   15 +++
>  drivers/usb/host/ehci-exynos.c                     |  129 +++++++++++++++++---
>  2 files changed, 124 insertions(+), 20 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
