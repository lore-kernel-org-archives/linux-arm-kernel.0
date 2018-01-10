From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 10 Jan 2018 20:15:09 +0000
Subject: [RFC PATCH 2/2] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <CAOFm3uFnzp4xPW=65A5Xyshaj-6PJx94PLi_nm4+c+csFznz-g@mail.gmail.com>
References: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
 <1515449797-5629-3-git-send-email-jollys@xilinx.com>
 <CAOFm3uFnzp4xPW=65A5Xyshaj-6PJx94PLi_nm4+c+csFznz-g@mail.gmail.com>
Message-ID: <DM2PR0201MB0767021EC0A57CF260E30895B8110@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,
Thanks for the review.
Will fix all SPDX tags in next version.

Thanks,
Jolly Shah

> -----Original Message-----
> From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
> Sent: Tuesday, January 09, 2018 4:53 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@codeaurora.org>; Michal Simek <michal.simek@xilinx.com>; linux-
> clk at vger.kernel.org; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; LKML <linux-
> kernel at vger.kernel.org>; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>
> Subject: Re: [RFC PATCH 2/2] drivers: clk: Add ZynqMP clock driver
> 
> Jolly,
> 
> On Mon, Jan 8, 2018 at 11:16 PM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> > This patch adds CCF compliant clock driver for ZynqMP.
> > Clock driver queries supported clock information from
> > firmware and regiters pll and output clocks with CCF.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Tejas Patel <tejasp@xilinx.com>
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> 
> <snip>
> 
> 
> >  .../devicetree/bindings/clock/zynq_mpsoc.txt       | 163 +++++
> >  drivers/clk/Kconfig                                |   1 +
> >  drivers/clk/Makefile                               |   1 +
> >  drivers/clk/zynqmp/Kconfig                         |   8 +
> >  drivers/clk/zynqmp/Makefile                        |   3 +
> >  drivers/clk/zynqmp/clk-gate-zynqmp.c               | 158 +++++
> >  drivers/clk/zynqmp/clk-mux-zynqmp.c                | 190 ++++++
> >  drivers/clk/zynqmp/clkc.c                          | 707 +++++++++++++++++++++
> >  drivers/clk/zynqmp/divider.c                       | 239 +++++++
> >  drivers/clk/zynqmp/pll.c                           | 384 +++++++++++
> >  include/linux/clk/zynqmp.h                         |  46 ++
> >  11 files changed, 1900 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/clock/zynq_mpsoc.txt
> >  create mode 100644 drivers/clk/zynqmp/Kconfig
> >  create mode 100644 drivers/clk/zynqmp/Makefile
> >  create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
> >  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
> >  create mode 100644 drivers/clk/zynqmp/clkc.c
> >  create mode 100644 drivers/clk/zynqmp/divider.c
> >  create mode 100644 drivers/clk/zynqmp/pll.c
> >  create mode 100644 include/linux/clk/zynqmp.h
> >
