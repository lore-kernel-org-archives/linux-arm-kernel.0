From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 25 Sep 2018 09:11:13 +0000
Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
In-Reply-To: <AM0PR04MB421176CFEF18F815CE0EC1A980010@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421169829CFE1A6A32DCC209802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421153E1441FBE356E1B859E800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB421176CFEF18F815CE0EC1A980010@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211732CC6C078017C8B849680160@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's been a few months without comments.

Shawn & Stephen,
Would you provide some suggestions on how to handle this?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Thursday, September 6, 2018 11:25 AM
> To: linux-clk at vger.kernel.org; sboyd at kernel.org; shawnguo at kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> mturquette at baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> 
> Hi Stephen,
> 
> Would you shine some lights on how to proceed?
> 
> Regards
> Dong Aisheng
> 
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Monday, August 27, 2018 11:46 AM
> > To: linux-clk at vger.kernel.org; sboyd at kernel.org; shawnguo at kernel.org
> > Cc: linux-kernel at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org;
> > mturquette at baylibre.com; Anson Huang <anson.huang@nxp.com>; Jacky
> Bai
> > <ping.bai@nxp.com>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> >
> > Kindly ping again...  This is really pending too long...
> >
> > Stephen & Shawn,
> > Any suggestion on how to proceed this patch set?
> >
> > Regards
> > Dong Aisheng
> >
> > > -----Original Message-----
> > > From: A.s. Dong
> > > Sent: Thursday, July 26, 2018 9:51 AM
> > > To: linux-clk at vger.kernel.org; sboyd at kernel.org
> > > Cc: linux-kernel at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org;
> > > mturquette at baylibre.com; shawnguo at kernel.org; Anson Huang
> > > <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: RE: [PATCH V4 0/9] clk: add imx7ulp clk support
> > >
> > > Hi Stephen,
> > >
> > > Do you have a chance to look at it?
> > > This patch series has been pending for quite a long time without
> > > much comments.
> > >
> > > Regards
> > > Dong Aisheng
> > >
> > > > -----Original Message-----
> > > > From: A.s. Dong
> > > > Sent: Wednesday, July 18, 2018 9:37 PM
> > > > To: linux-clk at vger.kernel.org
> > > > Cc: linux-kernel at vger.kernel.org;
> > > > linux-arm-kernel at lists.infradead.org;
> > > > sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org;
> > > Anson
> > > > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-
> > > > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > > > Subject: [PATCH V4 0/9] clk: add imx7ulp clk support
> > > >
> > > > This is a rebased version of below patch series against latest clk tree.
> > > > [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> > > > https://lkml.org/lkml/2018/3/16/310
> > > >
> > > > This patch series intends to add imx7ulp clk support.
> > > >
> > > > i.MX7ULP Clock functions are under joint control of the System
> > > > Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> > > > modules, and Core Mode Controller (CMC)1 blocks
> > > >
> > > > The clocking scheme provides clear separation between M4 domain
> > > > and
> > > > A7 domain. Except for a few clock sources shared between two
> > > > domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> > > > and and the Fast IRC clock (FIRCLK), clock sources and clock
> > > > management are separated and contained within each domain.
> > > >
> > > > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0
> modules.
> > > > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> > > >
> > > > Note: this series only adds A7 clock domain support as M4 clock
> > > > domain will be handled by M4 seperately.
> > > >
> > > > Change Log:
> > > > v3->v4:
> > > >  * rebased to latest kernel
> > > >  * make scg and pcc separate nodes according to Rob's suggestion
> > > >
> > > > v2->v3:
> > > >  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible
> racy
> > > >    Others no changes.
> > > >
> > > > v1->v2:
> > > >  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE
> > > > dividers
> > > >  * use clk_hw apis to register clocks
> > > >  * use of_clk_add_hw_provider
> > > >  * split the clocks register process into two parts: early part for possible
> > > >    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later
> > > > part
> > > for
> > > >    the left normal peripheral clocks registered by a platform driver.
> > > >
> > > > Dong Aisheng (9):
> > > >   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
> > > >   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag
> > support
> > > >   clk: imx: add pllv4 support
> > > >   clk: imx: add pfdv2 support
> > > >   clk: imx: add composite clk support
> > > >   dt-bindings: clock: add imx7ulp clock binding doc
> > > >   clk: imx: make mux parent strings const
> > > >   clk: imx: implement new clk_hw based APIs
> > > >   clk: imx: add imx7ulp clk driver
> > > >
> > > >  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
> > > >  drivers/clk/clk-divider.c                          | 152
> > > +++++++++++++++
> > > >  drivers/clk/clk-fractional-divider.c               |  10 +
> > > >  drivers/clk/imx/Makefile                           |   6 +-
> > > >  drivers/clk/imx/clk-busy.c                         |   2 +-
> > > >  drivers/clk/imx/clk-composite.c                    |  85
> +++++++++
> > > >  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
> > > >  drivers/clk/imx/clk-imx7ulp.c                      | 209
> > > +++++++++++++++++++++
> > > >  drivers/clk/imx/clk-pfdv2.c                        | 201
> > > ++++++++++++++++++++
> > > >  drivers/clk/imx/clk-pllv4.c                        | 182
> > > ++++++++++++++++++
> > > >  drivers/clk/imx/clk.c                              |  22 +++
> > > >  drivers/clk/imx/clk.h                              |  92
> ++++++++-
> > > >  include/dt-bindings/clock/imx7ulp-clock.h          | 109
> > +++++++++++
> > > >  include/linux/clk-provider.h                       |  17 ++
> > > >  14 files changed, 1166 insertions(+), 10 deletions(-)  create
> > > > mode
> > > > 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > > >  create mode 100644 drivers/clk/imx/clk-composite.c  create mode
> > > > 100644 drivers/clk/imx/clk-imx7ulp.c  create mode 100644
> > > > drivers/clk/imx/clk- pfdv2.c  create mode 100644
> > > > drivers/clk/imx/clk-pllv4.c  create mode 100644
> > > > include/dt-bindings/clock/imx7ulp-clock.h
> > > >
> > > > --
> > > > 2.7.4
