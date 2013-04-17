From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 17 Apr 2013 12:06:19 +0200
Subject: [PATCH] ARM i.MX6q: Fix periph_clk2_sel and periph2_clk2_sel
 clocks
In-Reply-To: <516E5931.5010904@de.bosch.com>
References: <1365675812-21600-1-git-send-email-p.zabel@pengutronix.de>
 <20130412030228.GF16970@S2101-09.ap.freescale.net>
 <1365757419.5330.17.camel@pizza.hi.pengutronix.de>
 <516E5931.5010904@de.bosch.com>
Message-ID: <1366193179.4389.1.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 17.04.2013, 10:11 +0200 schrieb Dirk Behme:
> On 12.04.2013 11:03, Philipp Zabel wrote:
> > Am Freitag, den 12.04.2013, 11:02 +0800 schrieb Shawn Guo:
> >> On Thu, Apr 11, 2013 at 12:23:32PM +0200, Philipp Zabel wrote:
> >>> The periph_clk2_sel mux can be set to pll3, pll1, or
> >>> osc/pll2-bypass/pll2_burn_in_clk.
> >> Looking at IMX6DQRM Rev. 0, 11/2012, I see
> >>
> >> 13?12 periph_clk2_sel: Selector for peripheral clk2 clock multiplexer
> >>
> >> 	00 derive clock from pll3_sw_clk
> >> 	01 derive clock from pll1_ref_clk
> >> 	10 derive clock from pll2_burn_in_clk (default)
> >> 	11 reserved
> >>
> >> Are you sure pll1_ref_clk actually means pll1_sys?
> > 
> > No, pll1_sys indeed is pll1_sw_clk, not pll1_ref_clk.
> > 
> >> I searched the
> >> document and word "pll1_ref_clk" occurs only once.  But Figure 18-5. BUS
> >> clock generation on page 819 suggests it's OSC_CLK (24M).
> > 
> > This is consistent (24 MHz osc is the pll1 reference), and thus might be
> > correct. I'll fix the patch to keep periph_clk2_sels[1] = "osc".
> 
> Any update on this?

Thank you for the reminder, I've sent v2.

regards
Philipp
