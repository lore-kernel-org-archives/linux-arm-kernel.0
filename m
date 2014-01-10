From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jan 2014 10:53:06 -0800
Subject: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
In-Reply-To: <20140109222322.7168.74522@quantum>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <20140109222322.7168.74522@quantum>
Message-ID: <20140110185305.GN31323@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [140109 14:25]:
> Quoting Tero Kristo (2014-01-09 06:00:11)
> > Hi,
> > 
> > So, bad luck number release for this, as v12 wasn't sufficient still.
> > 
> > Changes compared to previous version:
> > - Dropped any changes to generic clock drivers, as it seems impossible
> >   to agree anything in short term, this means the patch set shrank in
> >   size from 49 patches to 40 (first 9 patches were dropped).
> > - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
> >   to drivers/clk/ti, and made the modifications needed to the TI version
> >   of the clock drivers only (based on discussions with Mike, this is fine)
> > - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
> >   with any generic implementation we might have at some point, migrating
> >   this to the generic version should be easy enough also.
> > - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
> >   versions and resulted into an orphan clock node
> > - Fixed compile problem for omap5 only build reported by Felipe
> > - Fixed a couple of sparse warnings
> > - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
> >   instead of __raw_readl / __raw_writel
> 
> Hi Tero,
> 
> This approach takes care of all of my concerns with this series. Thanks
> for your long suffering patience on it.
> 
> It seems some build errors are cropping up, so once those are fixed then
> I'll be happy to merge clk-next-dt-clks-v13 into clk-next for 3.14.

I'm fine with Mike merging these all via the clock tree assuming no more
pending comments. For the patches changed from the last time around,
please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
