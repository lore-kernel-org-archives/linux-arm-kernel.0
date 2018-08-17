From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 17 Aug 2018 02:33:52 +0000
Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
In-Reply-To: <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Do you want me to resend this series for review?
It seems have been pending for quite a long time.

Thor just pinged me for its status as he wants to use it.

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Wednesday, June 20, 2018 10:54 AM
> To: linux-clk at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
> 
> Ping....
> 
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Friday, May 25, 2018 6:37 PM
> > To: linux-clk at vger.kernel.org
> > Cc: linux-kernel at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org;
> > sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org; dl-
> > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
> >
> > This patch series is a continue of discussion from here,
> > https://patchwork.kernel.org/patch/9986293/
> > that some users may want to handle all available clocks from device
> > tree without need to know the detailed clock information likes clock
> > numbers and names. This is useful in writing some generic drivers to handle
> clock part.
> >
> > Note:
> > This patch series is tested on MX6Q SDB cpufreq driver with a minor
> > change to switch to use clk_bulk_get_all.
> > But patch 4 only test compiling. Hopefully someone could help test the
> > function.
> >
> > v2->v3:
> >  * address all comments from Stephen
> >  * fix build warnings on other architectures.
> > v1->v2:
> >  * add clk_bulk_{get|put}_all() which only supports DT platform
> > currently
> >  * remove _all variants and the wrapper struct clk_bulk
> >  * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
> >    proves they need it because they don't have a struct device pointer.
> >
> > Dong Aisheng (4):
> >   clk: bulk: add of_clk_bulk_get()
> >   clk: add new APIs to operate on all available clocks
> >   clk: add managed version of clk_bulk_get_all
> >   video: simplefb: switch to use clk_bulk API to simplify clock
> >     operations
> >
> >  drivers/clk/clk-bulk.c         | 80
> > ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/clk-devres.c       | 24 +++++++++++++
> >  drivers/video/fbdev/simplefb.c | 66 +++++++---------------------------
> >  include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
> >  4 files changed, 180 insertions(+), 55 deletions(-)
> >
> > --
> > 2.7.4
