From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 28 Aug 2014 16:44:21 +0800
Subject: [RFC PATCH 1/2] ARM: imx: add BYPASS support for PLL clocks
In-Reply-To: <1409067313-32063-2-git-send-email-shawn.guo@freescale.com>
References: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
 <1409067313-32063-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140828084420.GG28777@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:35:12PM +0800, Shawn Guo wrote:
> The i.MX6 clock drivers currently hard-code all PLL clocks sourcing from
> OSC24M without BYPASS support.  The patch adds BYPASS and BYPASS_CLK_SRC
> selection for PLL clocks as per Figure 10-3. Primary Clock Generation
> in IMX6DQRM, i.e. both BYPASS_CLK_SRC and BYPASS bits are implemented as
> mux clocks, and ENABLE bit of PLL clocks is implemented as a gate clock
> after BYPASS mux.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Shengjiu,

Can you please test if this BYPASS support works good for your ESAI use
case?

Shawn
