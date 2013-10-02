From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 2 Oct 2013 18:57:54 +0200
Subject: [PATCH] clk: armada-370: fix tclk frequencies
In-Reply-To: <20131002162221.GN31178@titan.lakedaemon.net>
References: <1380729418-14393-1-git-send-email-simon.guinot@sequanux.org>
 <20131002162221.GN31178@titan.lakedaemon.net>
Message-ID: <20131002165754.GE1356@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 12:22:21PM -0400, Jason Cooper wrote:
> Simon,
> 
> On Wed, Oct 02, 2013 at 05:56:58PM +0200, Simon Guinot wrote:
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> 
> Could you elaborate on this?  What symptom did you notice?  How did this
> fix it?  When was the regression introduced?

Hi Jason,

While benchmarking Linux 3.12-rc3 on an Armada-370-RD, I noticed bad
networking performances... After some investigations, I found out that
the coalescence configuration (derived from the tclk) was suspect.

While checking for the tclk value, I found this typo. There is not much
to say about this patch except that the correct tclk frequencies for
Armada-370 are 166 and 200MHz, not 16.6 and 20MHz.

Simon

> 
> thx,
> 
> Jason.
> 
> > ---
> >  drivers/clk/mvebu/armada-370.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
> > index fc777bd..81a202d 100644
> > --- a/drivers/clk/mvebu/armada-370.c
> > +++ b/drivers/clk/mvebu/armada-370.c
> > @@ -39,8 +39,8 @@ static const struct coreclk_ratio a370_coreclk_ratios[] __initconst = {
> >  };
> >  
> >  static const u32 a370_tclk_freqs[] __initconst = {
> > -	16600000,
> > -	20000000,
> > +	166000000,
> > +	200000000,
> >  };
> >  
> >  static u32 __init a370_get_tclk_freq(void __iomem *sar)
> > -- 
> > 1.7.10.4
> > 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/b0c4d977/attachment.sig>
