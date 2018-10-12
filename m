From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Oct 2018 09:52:51 -0500
Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP
 power domain driver
In-Reply-To: <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
 <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
Message-ID: <20181012145251.GA6489@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 06:41:44PM +0000, Jolly Shah wrote:
> Ping for comments

Please see my comments on other ZynqMP firmware patches. In summary, I 
need to see a complete binding, not piecemeal additions.

Rob

> 
> Thanks,
> Jolly Shah
> 
> > -----Original Message-----
> > From: Jolly Shah [mailto:jolly.shah at xilinx.com]
> > Sent: Thursday, October 04, 2018 2:24 PM
> > To: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> > geert+renesas at glider.be; bjorn.andersson at linaro.org;
> > sean.wang at mediatek.com; m.szyprowski at samsung.com; Michal Simek
> > <michals@xilinx.com>; robh+dt at kernel.org; mark.rutland at arm.com
> > Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>
> > Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
> > domain driver
> > 
> > The zynqmp power domain driver communicates the usage requirements for
> > logical power domains / devices to the platform FW.
> > FW is responsible for choosing appropriate power states, taking Linux' usage
> > information into account.
> > 
> > This patch series is based on top of Xilinx firmware patch set:
> > https://patchwork.kernel.org/cover/10555405/
> > 
> > v3:
> >  - Changed binding to have FW node as a power controller as suggested by Rob
> >  - Updated FW driver to register it as mfd child devices from firmware probe
> >  - Move bindings location as suggested
> > 
> > v2:
> >  - Rebased on top of latest firmware driver patch series
> >  - Updated driver name from zynqmp-genpd to zynqmp-power-controller
> >  - Updated device tree bindings to move power controller node under firmware
> > node
> > 
> > Jolly Shah (1):
> >   drivers: soc: xilinx: Add ZynqMP power domain driver
> > 
> > Rajan Vaja (3):
> >   dt-bindings: power: Add ZynqMP power domain bindings
> >   firmware: xilinx: Add APIs to control node status/power
> >   firmware: xilinx: Add node IDs for zynqmp firmware
> > 
> >  .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
> >  drivers/firmware/xilinx/Kconfig                    |   1 +
> >  drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
> >  drivers/soc/xilinx/Kconfig                         |   9 +
> >  drivers/soc/xilinx/Makefile                        |   2 +
> >  drivers/soc/xilinx/zynqmp_pm_domains.c             | 403
> > +++++++++++++++++++++
> >  include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
> >  include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
> >  8 files changed, 659 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-
> > genpd.txt
> >  create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
> >  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> > 
> > --
> > 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
