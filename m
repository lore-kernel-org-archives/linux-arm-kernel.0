From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 4 Apr 2013 21:11:43 -0400
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <20130404093435.GK16404@kw.sim.vm.gnt>
References: <20130329184109.GA16404@kw.sim.vm.gnt> <51568B89.1060009@free.fr>
 <20130401163316.GC16404@kw.sim.vm.gnt> <515A5BC6.5000007@free.fr>
 <20130402114535.GR13280@titan.lakedaemon.net>
 <20130402125408.GH16404@kw.sim.vm.gnt>
 <20130402172454.GT13280@titan.lakedaemon.net>
 <515D0776.7050208@free.fr> <20130404080058.GJ16404@kw.sim.vm.gnt>
 <20130404093435.GK16404@kw.sim.vm.gnt>
Message-ID: <20130405011143.GX13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 11:34:35AM +0200, Simon Guinot wrote:
> On Thu, Apr 04, 2013 at 10:00:58AM +0200, Simon Guinot wrote:
> > On Thu, Apr 04, 2013 at 06:54:14AM +0200, Chris Moore wrote:
> > > Le 02/04/2013 19:24, Jason Cooper a ?crit :
> > > >On Tue, Apr 02, 2013 at 02:54:11PM +0200, Simon Guinot wrote:
...
> > > >As for the model number for the public board (#2), why can't we append
> > > >"-90003xx"?  See [1], Specifications tab.
> > > >
> > > >[1] http://www.lacie.com/us/products/product.htm?id=10597
> > > 
> > > This seems like a good idea to me but I don't think Simon favoured
> > > adding a model number.
> > > In any case Simon would know better than me whether this covers the
> > > models correctly.
> > > What do you think, Simon?
> > 
> > I am currently working on this numbers. It _could_ work. Apparently the
> > product ID is encoded in the numbers... as well as the case color and
> > size. Today I should meet someone with more informations about the model
> > number format.
> 
> Finally, the model number pattern "-90003xx" can't be used to match the
> CloudBox product. The number is indeed unique. It encodes product ID,
> storage capacity, case color and case size. But the pattern is not
> usable. If tomorrow a red CloudBox is released, the first digits could
> be completely different.
> 
> To illustrate that, have a look at:
> http://www.lacie.com/products/product.htm?id=10584.
> 
> The item numbers are 2000345, 9000225 and 9000226.

Thank for digging into this.

> Then we are back to the initial problem...
> 
> Maybe we could append some suffixes based on the version:
> 
> 1: cloudbox-v1
> 2: cloudbox-v2
> 
> Or better, suffix based on the other code names:
> 
> 1: cloudbox-ns2mini
> 2: cloudbox-familybox
> 
> Or even let the things as they are:
> 
> 1: netspace_v2_mini
> 2: cloudbox

In light of the above info, let's got with the third option.  If we
discover a different LaCie Cloudbox board down the road, we can add an
appropriately more specific compatible string to differentiate.  As you
can tell, I'd prefer to have something more specific in the original
commit, but we can only work with what we're given. :(

thx,

Jason.
