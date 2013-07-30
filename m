From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 30 Jul 2013 08:17:43 -0400
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <20130730015031.GK29970@voom.fritz.box>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
 <20130729172339.GT29916@titan.lakedaemon.net>
 <20130730015031.GK29970@voom.fritz.box>
Message-ID: <20130730121743.GB5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 11:50:31AM +1000, David Gibson wrote:
> On Mon, Jul 29, 2013 at 01:23:39PM -0400, Jason Cooper wrote:
> > On Mon, Jul 29, 2013 at 05:49:05PM +0100, Dave Martin wrote:
> > > On Mon, Jul 29, 2013 at 11:01:24AM -0400, Jason Cooper wrote:
> > > > On Mon, Jul 29, 2013 at 02:21:52AM +0200, Tomasz Figa wrote:
> > 
> > > > > b) What information should be specified in schemas? What level of 
> > > > >    granularity is required?
> > > > 
> > > > One item I don't see in this list is node ordering.  There's been some
> > > > discussion lately on deferred probing (re boot times).  If we were to
> > > > intentionally declare that DT are parsed in the order written, then a
> > > > lot of deferred probes could be avoided by moving eg the pinctrl node to
> > > > near the top of the tree.
> > > > 
> > > > This doesn't impact buses as much, since the nodes needing the bus are
> > > > already children.  However, anything accessed via phandles: pins,
> > > > clocks, regulators, etc could benefit from declaring and enforcing this.
> > > > Eg having the dtc warn when a phandle is used before it's corresponding
> > > > node is declared.
> > > > 
> > > > Not critical though, just a thought.
> > > 
> > > I don't think that siblings have any defined order in DT.  If reading a
> > > device tree, there's no guarantee you get nodes or properties out in the
> > > same order as the original .dts file.
> > 
> > That's why I raised the point.  If people think encoding initialization
> > order in the DT is a good idea, then we should change the dtc so it
> > compiles/decompiles in the same order.
> 
> I'm not actually sure what you mean by this.  dtc already preserves
> order between input and output.

This is an old comment (~ 1d, wow).  My position has evolved to seeing
if we can allow dtc to topsort nodes it can easily tell are needed first
as an optimization.  *Not* a requirement.  Deferred probing would still
be a fall back.

thx,

Jason.
