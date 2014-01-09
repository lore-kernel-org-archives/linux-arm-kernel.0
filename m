From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Jan 2014 12:43:36 -0600
Subject: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
In-Reply-To: <20140109184059.GM2417@saruman.home>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <20140109172217.GH2417@saruman.home>
 <20140109184059.GM2417@saruman.home>
Message-ID: <20140109184335.GN2417@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:40:59PM -0600, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jan 09, 2014 at 11:22:17AM -0600, Felipe Balbi wrote:
> > > Changes compared to previous version:
> > > - Dropped any changes to generic clock drivers, as it seems impossible
> > >   to agree anything in short term, this means the patch set shrank in
> > >   size from 49 patches to 40 (first 9 patches were dropped).
> > > - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
> > >   to drivers/clk/ti, and made the modifications needed to the TI version
> > >   of the clock drivers only (based on discussions with Mike, this is fine)
> > > - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
> > >   with any generic implementation we might have at some point, migrating
> > >   this to the generic version should be easy enough also.
> > > - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
> > >   versions and resulted into an orphan clock node
> > > - Fixed compile problem for omap5 only build reported by Felipe
> > > - Fixed a couple of sparse warnings
> > > - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
> > >   instead of __raw_readl / __raw_writel
> > 
> > just caught a build breakage. .config attached
> 
> forgot to give you build errors found, they're here:
> http://hastebin.com/jibuyuyoto.vbs
> 
> Also, just caught another build breakage:
> 
> http://hastebin.com/reravalupe.vbs
> 
> .config attached

hmm, quite a few configs are failing, seems like have DRA7xx without
OMAP4 or OMAP5 breaks builds.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/84025fce/attachment.sig>
