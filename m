From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 29 Aug 2014 10:53:51 +0800
Subject: [RFC PATCH 1/2] ARM: imx: add BYPASS support for PLL clocks
In-Reply-To: <20140829014947.GA2741@audiosh1>
References: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
 <1409067313-32063-2-git-send-email-shawn.guo@freescale.com>
 <20140828084420.GG28777@dragon> <20140829014947.GA2741@audiosh1>
Message-ID: <20140829025349.GH28777@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 09:49:50AM +0800, Shengjiu Wang wrote:
> On Thu, Aug 28, 2014 at 04:44:21PM +0800, Shawn Guo wrote:
> > On Tue, Aug 26, 2014 at 11:35:12PM +0800, Shawn Guo wrote:
> > > The i.MX6 clock drivers currently hard-code all PLL clocks sourcing from
> > > OSC24M without BYPASS support.  The patch adds BYPASS and BYPASS_CLK_SRC
> > > selection for PLL clocks as per Figure 10-3. Primary Clock Generation
> > > in IMX6DQRM, i.e. both BYPASS_CLK_SRC and BYPASS bits are implemented as
> > > mux clocks, and ENABLE bit of PLL clocks is implemented as a gate clock
> > > after BYPASS mux.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > 
> > Shengjiu,
> > 
> > Can you please test if this BYPASS support works good for your ESAI use
> > case?
> > 
> > Shawn
> 
> Yes, after test, one issue found. Please check.
> 
> -static const char *pll_bypass_src_sels[] = { "osc", "anaclk1", "anaclk2", "dummy", };
> +static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", "lvds2_in", "dummy", };

Ah, yes.  I will fix my code.

So doest that mean with the above fix, we can now source 24.576MHz from
board directly to ESAI with audio PLL in bypass mode?

Shawn
