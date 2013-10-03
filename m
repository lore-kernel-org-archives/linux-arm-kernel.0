From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 3 Oct 2013 11:00:58 +0200
Subject: [PATCH] clk: armada-370: fix tclk frequencies
In-Reply-To: <20131002170448.GO31178@titan.lakedaemon.net>
References: <1380729418-14393-1-git-send-email-simon.guinot@sequanux.org>
 <20131002162221.GN31178@titan.lakedaemon.net>
 <20131002165754.GE1356@kw.sim.vm.gnt>
 <20131002170448.GO31178@titan.lakedaemon.net>
Message-ID: <20131003090057.GF1356@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 01:04:49PM -0400, Jason Cooper wrote:
> On Wed, Oct 02, 2013 at 06:57:54PM +0200, Simon Guinot wrote:
> > On Wed, Oct 02, 2013 at 12:22:21PM -0400, Jason Cooper wrote:
> > > Simon,
> > > 
> > > On Wed, Oct 02, 2013 at 05:56:58PM +0200, Simon Guinot wrote:
> > > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > > 
> > > Could you elaborate on this?  What symptom did you notice?  How did this
> > > fix it?  When was the regression introduced?
> > 
> > Hi Jason,
> > 
> > While benchmarking Linux 3.12-rc3 on an Armada-370-RD, I noticed bad
> > networking performances... After some investigations, I found out that
> > the coalescence configuration (derived from the tclk) was suspect.
> > 
> > While checking for the tclk value, I found this typo. There is not much
> > to say about this patch except that the correct tclk frequencies for
> > Armada-370 are 166 and 200MHz, not 16.6 and 20MHz.
> 
> Yes, I know it's simple, but it's a huge help to us when trying to
> decide whether or not to flag it for stable.  fwiw, the regression was
> introduced by:
> 
>   6b72333d clk: mvebu: add Armada 370 SoC-centric clock init
> 
> and this should be applied from v3.11 onwards.

Ok, I will reword this commit. Note that this bug can't be called a
regression. The tclk frequencies array was wrong from the beginning:

  97fa4cf4: clk: mvebu: add mvebu core clocks

The commit you pointed out simply moves the typo. I am not familiar
with the stable process but if needed I can provide a patch against
some stable branches.

Please let know how do you want handle this.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/61a9c13c/attachment.sig>
