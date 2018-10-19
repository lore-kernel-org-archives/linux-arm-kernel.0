From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Oct 2018 07:16:35 +0100
Subject: [PATCH 0/4] Add SOCFPGA System Manager
In-Reply-To: <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
 <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
 <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
Message-ID: <20181019061635.GH4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018, Thor Thayer wrote:


> On 10/10/2018 09:42 AM, Thor Thayer wrote:
> > Hi
> > On 09/24/2018 05:09 PM, thor.thayer at linux.intel.com wrote:
> > > From: Thor Thayer <thor.thayer@linux.intel.com>
> > > 
> > > Add MFD driver for ARM64 SOCFPGA System Manager to steer
> > > System Manager calls appropriately.
> > > The SOCFPGA System Manager includes registers from several
> > > SOC peripherals.
> > > 
> > > On ARM32, syscon handles this aggregated register grouping.
> > > Redirect System Manager calls to syscon for ARM32 SOCFPGA
> > > systems.
> > > 
> > > The ARM64 System Manager can only be accessed from priority
> > > level EL3 so this new MFD driver handles the calls to EL3.
> > > 
> > > Thor Thayer (4):
> > > ?? mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
> > > ?? ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> > > ?? arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
> > > ?? net: stmmac: socfpga: Convert to shared System Manager driver
> > > 
> > > ? MAINTAINERS??????????????????????????????????????? |?? 6 +
> > > ? arch/arm/configs/socfpga_defconfig???????????????? |?? 1 +
> > > ? arch/arm64/configs/defconfig?????????????????????? |?? 1 +
> > > ? drivers/mfd/Kconfig??????????????????????????????? |?? 9 +
> > > ? drivers/mfd/Makefile?????????????????????????????? |?? 1 +
> > > ? drivers/mfd/altera-sysmgr.c??????????????????????? | 310
> > > +++++++++++++++++++++
> > > ? .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c??? |?? 4 +-
> > > ? include/linux/mfd/altera-sysmgr.h????????????????? | 113 ++++++++
> > > ? 8 files changed, 444 insertions(+), 1 deletion(-)
> > > ? create mode 100644 drivers/mfd/altera-sysmgr.c
> > > ? create mode 100644 include/linux/mfd/altera-sysmgr.h
> > > 
> > Gentle ping.
> 
> Gentle ping again...
> 
> Any comments on this patch series?

"Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway so resending with any comments addressed is generally a
much better approach."

In this case, the we are too late in the series to have these
applied.  Maintainers are generally preparing their submissions for
the merge-window.  The MFD component of this set is marked as "To
Review" and I will get around to it when time is more abundant.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
