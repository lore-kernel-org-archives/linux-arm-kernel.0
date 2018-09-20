From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 20 Sep 2018 02:14:21 +0000
Subject: [PATCH V6 0/4] clk: new APIs to handle all available clocks
In-Reply-To: <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
Message-ID: <AM0PR04MB4211B170CAC1B3F9E7356AF980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Thor Thayer [mailto:thor.thayer at linux.intel.com]
> Sent: Wednesday, September 19, 2018 10:47 PM
> To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; hdegoede at redhat.com
> Subject: Re: [PATCH V6 0/4] clk: new APIs to handle all available clocks
> 
> Hi,
> 
> On 09/16/2018 08:24 AM, A.s. Dong wrote:
> > Ping again
> >
> >> -----Original Message-----
> >> From: A.s. Dong
> >> Sent: Thursday, September 6, 2018 11:23 AM
> >> To: linux-clk at vger.kernel.org
> >> Cc: linux-kernel at vger.kernel.org;
> >> linux-arm-kernel at lists.infradead.org;
> >> sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org;
> >> thor.thayer at linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
> >> hdegoede at redhat.com
> >> Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available
> >> clocks
> >>
> >> Gently ping...
> >>
> >>> -----Original Message-----
> >>> From: A.s. Dong
> >>> Sent: Friday, August 31, 2018 12:46 PM
> >>> To: linux-clk at vger.kernel.org
> >>> Cc: linux-kernel at vger.kernel.org;
> >>> linux-arm-kernel at lists.infradead.org;
> >>> sboyd at kernel.org; mturquette at baylibre.com; shawnguo at kernel.org;
> >>> thor.thayer at linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
> >>> hdegoede at redhat.com; A.s. Dong <aisheng.dong@nxp.com>
> >>> Subject: [PATCH V6 0/4] clk: new APIs to handle all available clocks
> >>>
> >>> This patch series is a continue of discussion from here,
> >>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fp
> >>>
> atchwork.kernel.org%2Fpatch%2F9986293%2F&amp;data=02%7C01%7Caishe
> ng.
> >>>
> dong%40nxp.com%7Cb79f0aa8c74c4f935adb08d61e3e7944%7C686ea1d3bc
> 2b4c6f
> >>>
> a92cd99c5c301635%7C0%7C0%7C636729651014549633&amp;sdata=zh0RP
> Vt4pqyM
> >>> 84SUFRpDcbIH583JNONlBhTQeLYwDFo%3D&amp;reserved=0
> >>> that some users may want to handle all available clocks from device
> >>> tree without need to know the detailed clock information likes clock
> >>> numbers and names. This is useful in writing some generic drivers to
> >>> handle
> >> clock part.
> >>>
> >>> Note:
> >>> This patch series is tested on MX6Q SDB cpufreq driver with a minor
> >>> change to switch to use clk_bulk_get_all.
> >>> But patch 4 only test compiling. Hopefully someone could help test
> >>> the function.
> >>>
> >>> v3->v4:
> >>>   * improve 'devres->clks = *clks' according to Stephen's suggestion
> >>> v2->v3:
> >>>   * address all comments from Stephen
> >>>   * fix build warnings on other architectures.
> >>> v1->v2:
> >>>   * add clk_bulk_{get|put}_all() which only supports DT platform
> >>> currently
> >>>   * remove _all variants and the wrapper struct clk_bulk
> >>>   * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
> >>>     proves they need it because they don't have a struct device pointer.
> >>>
> >>> Dong Aisheng (4):
> >>>    clk: bulk: add of_clk_bulk_get()
> >>>    clk: add new APIs to operate on all available clocks
> >>>    clk: add managed version of clk_bulk_get_all
> >>>    video: simplefb: switch to use clk_bulk API to simplify clock
> >>>      operations
> >>>
> >>>   drivers/clk/clk-bulk.c         | 80
> >>> ++++++++++++++++++++++++++++++++++++++++++
> >>>   drivers/clk/clk-devres.c       | 24 +++++++++++++
> >>>   drivers/video/fbdev/simplefb.c | 72 ++++++++++---------------------------
> >>>   include/linux/clk.h            | 65
> >>> +++++++++++++++++++++++++++++++++-
> >>>   4 files changed, 186 insertions(+), 55 deletions(-)
> >>>
> >>> --
> >>> 2.7.4
> >
> Just checking on the status of this patch. The clock routines (patches
> 1-3) are useful for one of my drivers but if they aren't accepted or will take a
> long time to be accepted, I'll need to refactor my driver.
> 

Thanks for this information.

Stephen,
Would you help to proceed this?

Regards
Dong Aisheng
