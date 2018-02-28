From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Feb 2018 11:32:37 +0000
Subject: [PATCH] clk: imx: imx7d: correct video pll clock tree
In-Reply-To: <20180108104111.GE32635@b29396-OptiPlex-7040>
References: <1514999361-2723-1-git-send-email-Anson.Huang@nxp.com>
 <20180108104111.GE32635@b29396-OptiPlex-7040>
Message-ID: <VI1PR04MB132809996C5C2BFCF0B482B8F5C70@VI1PR04MB1328.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...

Looks like this patch is missed on latest tree, so ping it.

Anson Huang
Best Regards!


> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86 at gmail.com]
> Sent: Monday, January 8, 2018 6:41 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: linux-kernel at vger.kernel.org; linux-clk at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; sboyd at codeaurora.org;
> mturquette at baylibre.com; Fabio Estevam <fabio.estevam@nxp.com>;
> kernel at pengutronix.de; shawnguo at kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH] clk: imx: imx7d: correct video pll clock tree
> 
> On Thu, Jan 04, 2018 at 01:09:21AM +0800, Anson Huang wrote:
> > There is a test divider and post divider in video PLL, test divider is
> > placed before post divider, all clocks that can select parent from
> > video PLL should be from post divider, NOT from pll_video_main, below
> > are clock tree dump before and after this patch:
> >
> > Before:
> > pll_video_main
> >    pll_video_main_bypass
> >       pll_video_main_clk
> >          lcdif_pixel_src
> >             lcdif_pixel_cg
> >                lcdif_pixel_pre_div
> >                   lcdif_pixel_post_div
> >                      lcdif_pixel_root_clk
> > After:
> > pll_video_main
> >    pll_video_main_bypass
> >       pll_video_main_clk
> >          pll_video_test_div
> >             pll_video_post_div
> >                lcdif_pixel_src
> >                   lcdif_pixel_cg
> >                      lcdif_pixel_pre_div
> >                         lcdif_pixel_post_div
> >                            lcdif_pixel_root_clk
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Regards
> Dong Aisheng
