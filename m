From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 02 Apr 2014 11:54:24 +0100
Subject: Bug(?) in patch "arm64: Implement coherent DMA API based on
 swiotlb" (was Re: [GIT PULL] arm64 patches for 3.15)
In-Reply-To: <20140402092032.GB31892@arm.com>
References: <20140331175230.GA7480@arm.com>
 <1396368657.3681.17.camel@linaro1.home> <20140401172939.GG20061@arm.com>
 <1396428722.3554.20.camel@linaro1.home> <20140402092032.GB31892@arm.com>
Message-ID: <1396436064.3554.53.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-02 at 10:20 +0100, Catalin Marinas wrote:
> On Wed, Apr 02, 2014 at 09:52:02AM +0100, Jon Medhurst (Tixy) wrote:
> > On Tue, 2014-04-01 at 18:29 +0100, Catalin Marinas wrote:

> > > +1:	tst	x0, x3				// start cache line aligned?
> > > +	bic	x0, x0, x3
> > > +	b.eq	2f
> > > +	dc	civac, x0			// clean & invalidate D / U line
> > > +	b	3f
> > > +2:	dc	ivac, x0			// invalidate D / U line
> > > +3:	add	x0, x0, x2
> > >  	cmp	x0, x1
> > >  	b.lo	1b
> > 
> > The above obviously also needs changing to branch to 3b
> 
> Good point.

Actually, it should be 2b :-)

-- 
Tixy
