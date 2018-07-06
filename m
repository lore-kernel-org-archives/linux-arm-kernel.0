From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 10:15:34 -0700
Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
In-Reply-To: <20180701021947.GA4348@dragon>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <20180628005217.GC22683@dragon>
 <153029757874.143105.17774476792947607999@swboyd.mtv.corp.google.com>
 <20180701021947.GA4348@dragon>
Message-ID: <153089733418.143105.7025289108790540252@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2018-06-30 19:19:49)
> On Fri, Jun 29, 2018 at 11:39:38AM -0700, Stephen Boyd wrote:
> > Quoting Shawn Guo (2018-06-27 17:52:18)
> > > On Mon, Jun 25, 2018 at 03:14:39AM +0000, Anson Huang wrote:
> > > > Gentle Ping...
> > > 
> > > I cannot apply this dts patch until the clock patch is landed on
> > > mainline, because it has a dependency on new clock ID IMX6UL_CLK_GPIO1
> > > created by clock patch.
> > > 
> > 
> > Does it matter if that clk ID changes across branches? Or is everything
> > good if it just exists as some number?
> 
> We use macro IMX6UL_CLK_GPIO1 instead of hard-coded number in DTS.  So
> it doesn't matter if IMX6UL_CLK_GPIO1 changes.
> 
> > The patch adding the define
> > conflicts with another patch to fix the numbering scheme to be
> > incremental instead of changing IMX6UL and IMX6ULL which is annoying.
> > I'll probably make a topic branch just for the fix and merge it into
> > clk-fixes and this branch so you can pick it up from there if you like.
> 
> It will be good if you can have a topic branch.  Otherwise, we are also
> fine to wait till the clock patches lands on mainline.
> 

Ok. The topic branch is out there as clk-imx-gpio-gates
