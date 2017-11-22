From: greg@kroah.com (Greg KH)
Date: Wed, 22 Nov 2017 15:49:59 +0100
Subject: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
In-Reply-To: <a443e88e-3abd-0dab-2828-9753326e8d5d@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
 <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
 <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
 <20171122075124.GA26583@kroah.com>
 <a443e88e-3abd-0dab-2828-9753326e8d5d@codeaurora.org>
Message-ID: <20171122144959.GA8081@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 08:42:35AM -0600, Timur Tabi wrote:
> On 11/22/17 1:51 AM, Greg KH wrote:
> > Ick, no, why?  What is wrong with removing this function as is?  Don't
> > mark something as __depreciated if there are no in-kernel users, just
> > delete it and move on.
> > 
> > If you have out-of-tree drivers, then yes, they can make a wrapper for
> > this function like this if they really feel the need, or they can get
> > their code merged:)
> 
> Sorry, I guess I should have been clearer.  My suggestion was to fix some of
> the drivers where the domain can be determined, and for the rest, just mark
> the old function as deprecated.

So the build now gets warnings?  That's annoying, and then someone else
will have to make the exact same patches that were created here?

> If that's still a terrible idea, well, okay.  I'm just unsure that simply
> hard-coding a 0 for the domain for some drivers is really a solution.  Don't
> we really want all drivers to properly support all domains?

I bet all of those drivers don't care because they are running only in
systems with 1 domain, otherwise they would be broken today, right?  But
really, it shouldn't be that hard to get to the "real" PCI device to
provide the correct pointer to the domain for most of these, as I
pointed out in one patch review already.

thanks,

greg k-h
