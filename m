From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 22 Mar 2017 15:25:01 +0100
Subject: [PATCH/RFC v2 0/4] iommu/ipmmu-vmsa: IPMMU slave device
 whitelist V2
In-Reply-To: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
References: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Message-ID: <20170322142501.GM29659@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 03:14:07PM +0900, Magnus Damm wrote:
> iommu/ipmmu-vmsa: IPMMU slave device whitelist V2
> 
> [PATCH/RFC v2 1/4] iommu/of: Skip IOMMU devices disabled in DT
> [PATCH/RFC v2 2/4] iommu/ipmmu-vmsa: Get rid of disabled device check
> [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Check devices in xlate()
> [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Opt-in slave devices based on ES version
> 
> Here's an updated prototype that shows how DT integration of IPMMU details
> may be integrated and merged upstream based on SoC data sheet ahead of
> time followed by enablement in the IPMMU driver code once the appropriate
> SoC ES version has been released and the hardware has been tested.
> 
> Changes since V1:
>  - Broke out patch 1 from the IPMMU driver
>  - Moved slave device check from ->add_device() to ->xlate() (Thanks Robin!)
>  - Updated white list patch to hook into ->xlate()
> 
> Patch 1 may be suitable for upstream merge, however other patches should
> in the future if agreed on be rolled into the IPMMU driver series.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Developed on top of renesas-drivers-2017-01-24-v4.10-rc5
> 
>  drivers/iommu/ipmmu-vmsa.c |   59 +++++++++++++++++++++++---------------------
>  drivers/iommu/of_iommu.c   |    2 -
>  2 files changed, 33 insertions(+), 28 deletions(-)

For the series:

Reviewed-by: Joerg Roedel <jroedel@suse.de>
