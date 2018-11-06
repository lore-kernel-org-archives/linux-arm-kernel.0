From: MNARANI@xilinx.com (Manish Narani)
Date: Tue, 6 Nov 2018 10:42:09 +0000
Subject: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
In-Reply-To: <20181106100329.GC13712@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <20181106100329.GC13712@zn.tnic>
Message-ID: <DM6PR02MB52278C1B02960DD084D5A25BC1CB0@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Tuesday, November 6, 2018 3:34 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; Michal Simek
> <michals@xilinx.com>; mchehab at kernel.org; amit.kucheria at linaro.org;
> sudeep.holla at arm.com; leoyang.li at nxp.com; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> edac at vger.kernel.org
> Subject: Re: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
> 
> On Thu, Oct 25, 2018 at 11:36:55AM +0530, Manish Narani wrote:
> > Change in v10:
> > 	- Moved the checking for ce_cnt and ue_cnt before the readl() call
> > 	- Aligned arguments on the opening brace in setup_irq()
> >
> > Manish Narani (6):
> >   edac: synopsys: Add error handling for NULL in probe()
> >   dt: bindings: Document ZynqMP DDRC in Synopsys documentation
> >   edac: synopsys: Add macro defines for ZynqMP DDRC
> >   edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
> >   arm64: zynqmp: Add DDRC node
> >   edac: synopsys: Add Error Injection support for ZynqMP DDRC
> >
> >  .../bindings/memory-controllers/synopsys.txt       |  27 +-
> >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
> >  drivers/edac/Kconfig                               |   2 +-
> >  drivers/edac/synopsys_edac.c                       | 911 ++++++++++++++++++++-
> >  4 files changed, 918 insertions(+), 29 deletions(-)
> 
> Ok, patches pushed here:
> 
> (minus https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-
> manish.narani at xilinx.com)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-4.21-
> synps
> 
Thanks a lot for your support.

> Please run this on the hw before I queue it for linux-next.
I have tested this and verified as working fine on hardware. You can go ahead and queue it for linux-next.

Thanks,
Manish
