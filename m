From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 12:04:49 -0700
Subject: [PATCH 1/2] clk: cache parent clocks only for muxes
In-Reply-To: <20120606104759.GN8262@n2100.arm.linux.org.uk>
References: <1338973891-28719-1-git-send-email-rnayak@ti.com>
 <1338973891-28719-2-git-send-email-rnayak@ti.com>
 <20120606104759.GN8262@n2100.arm.linux.org.uk>
Message-ID: <20120612190449.GH19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120606-11:47, Russell King - ARM Linux wrote:
> On Wed, Jun 06, 2012 at 02:41:30PM +0530, Rajendra Nayak wrote:
> > caching parent clocks makes sense only when a clock has more
> > than one parent (mux clocks).
> > Avoid doing this for every other clock.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  drivers/clk/clk.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 687b00d..40568e9 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1229,7 +1229,7 @@ int __clk_init(struct device *dev, struct clk *clk)
> >  	 * If clk->parents is not NULL we skip this entire block.  This allows
> >  	 * for clock drivers to statically initialize clk->parents.
> >  	 */
> > -	if (clk->num_parents && !clk->parents) {
> > +	if ((clk->num_parents > 1) && !clk->parents) {
> 
> You don't need the additional parens here.  Please learn the C precedence
> rules.  Additional unnecessary parens can make expressions much harder
> to read.

Rajendra,

I've taken this patch into clk-next for testing.  I've fixed up the
extra parens locally, so no need for a resend.

Regards,
Mike
