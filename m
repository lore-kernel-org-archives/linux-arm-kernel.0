From: s-anna@ti.com (Suman Anna)
Date: Fri, 22 Sep 2017 12:18:16 -0500
Subject: [PATCH 0/8] Add hwmod data for IPU & DSP processors/MMUs
In-Reply-To: <20170821234818.4755-1-s-anna@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
Message-ID: <d4715d1e-8113-050b-9a0f-77f4a4486081@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 08/21/2017 06:48 PM, Suman Anna wrote:
> Hi Tony,
> 
> The following series adds the hwmod data and the corresponding
> pdata quirks for the various MMUs associated with the IPU and DSP
> processors on DRA7xx/AM57xx SoCs. This is part 1 of the patches
> for enabling the MMUs on DRA7 SoCs (OMAP4 and OMAP5 are already
> supported on mainline) and providing a baseline for adding the
> OMAP remoteproc driver. The hwmod data for the consumers of these
> MMUs - IPU and DSP processors is also added on OMAP5 and DRA7 SoCs,
> with an update to the OMAP4 ones.
> 
> Patches are baselined on your current for-next branch with commit
> a70cb93b6c2f ("Merge branch 'omap-for-v4.14/dt-v3' into for-next").
> 
> I have tested the patches on current TI DRA7xx/AM57xx boards (DRA7,
> DRA72, DRA71, DRA76 EVMs, AM571x & AM572x IDKs and AM57xx BeagleBoard-X15)
> as well as the OMAP4 Panda and OMAP5 uEVM.

Ping on this series. Tero's clkctrl series changes are orthogonal to
these changes.

regards
Suman

> 
> regards
> Suman
> 
> Suman Anna (8):
>   ARM: DRA7: hwmod data: Add MMU data for IPUs
>   ARM: DRA7: hwmod data: Add MMU data for DSPs
>   ARM: OMAP2+: Extend iommu pdata-quirks to DRA7 IPUs
>   ARM: OMAP2+: Extend iommu pdata-quirks to DRA7 DSPs
>   ARM: OMAP4: hwmod_data: Remove modulemode from IPU/DSP hwmods
>   ARM: OMAP5: hwmod_data: Add data for IPU & DSP processors
>   ARM: DRA7: hwmod_data: Add data for IPUs
>   ARM: DRA7: hwmod_data: Add data for DSPs
> 
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   2 -
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  79 +++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 322 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c         |  11 +-
>  4 files changed, 411 insertions(+), 3 deletions(-)
> 
