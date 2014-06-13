From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Jun 2014 09:13:21 -0400
Subject: [PATCH V2 05/19] irqchip: crossbar: Change allocation logic by
 reversing search for free irqs
In-Reply-To: <539A95A3.1010301@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-6-git-send-email-r.sricharan@ti.com>
 <20140612125615.GT8664@titan.lakedaemon.net>
 <539A95A3.1010301@ti.com>
Message-ID: <20140613131321.GG8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 11:39:39AM +0530, Sricharan R wrote:
> Hi Jason,
> 
> On Thursday 12 June 2014 06:26 PM, Jason Cooper wrote:
> > On Thu, Jun 12, 2014 at 05:23:13PM +0530, Sricharan R wrote:
> >> From: Nishanth Menon <nm@ti.com>
> >>
> >> Reverse the search algorithm to ensure that address mapping and IRQ
> >> allocation logics are proper. This can open up new bugs which are
> >> easily fixable rather than wait till allocation logic approaches
> >> the limit to find new bugs.
> > 
> > Could you expand on this logic some more?  What class of bugs are you
> > hoping to discover more easily?
> > 
> 
> class 1. address space errors -> example:
> reg = <a size_b>
> ti,max-irqs =  is a wrong parameter
> 
> class 2: irq-reserved list - which decides which entries in the
> address space is not actually wired in
> 
> class 3: wrong list of routable-irqs.
> 
> in general allocating from max to min tends to have benefits in
> ensuring the different issues that may be present in dts is easily
> caught at definition time, rather than at a later point in time.

Perfect, thanks for clarifying.  Please add this to the commit log when
you respin.

thx,

Jason.
