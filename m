From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jun 2014 13:46:34 +0100
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <6599289.0ZjjaMbRqj@wuerfel>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
 <53A160D1.8000908@ti.com> <20140618100411.GL23945@lee--X1>
 <6599289.0ZjjaMbRqj@wuerfel>
Message-ID: <20140624124634.GO13803@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > converting all addresses to to resources so drivers can easily pull
> > > > them out using platform_get_resource() and friends.  Pushing the reg
> > > 
> > > right. Can't we use of_address_to_resource here?
> > 
> > We could, but that would be an extra layer.  We'd be pulling the
> > address, putting it into a resource, then pulling it from the resource
> > for use.  If we're going to be pulling addresses out manually, we're
> > probably better off using of_get_address().  But again, we're just
> > carrying out functionality which is already provided by the
> > framework.
> 
> there is also of_ioremap().

Isn't this SPARK only?  And doesn't it require a populated resource?  
Which is what I'm saying is the issue here i.e. we don't have one.

> > > > properties down into a child node means that we have to now iterate
> > > > over the sub-nodes and pull them out manually.  This will lead to a
> > > 
> > > You anyway iterate while creating PHYs based on some constant. Now you have to
> > > iterate over the sub-nodes.
> > > > pretty messy implementation IMHO.
> > 
> > This much is true.
> > 
> > > > Can you point me in the direction of previous implementations where you
> > > > have stipulated the same set of constraints please?
> > > 
> > > ah.. there isn't any. The author of the other multi-phy driver [1] also feels
> > > this will just add to the complexity of the driver.
> > 
> > =:)
> > 
> > > Maybe we should ask the opinion of others?
> > 
> > We could.  I'll CC Arnd as he likes this PHY stuff. :)
> > 
> > > [1] -> http://www.spinics.net/lists/linux-sh/msg32087.html
> 
> Having sub-nodes for each individual PHY managed by a controller seems
> very reasonable to me. Making them show up as separate platform devices
> seems less useful though.

Are there any examples of other nodes with reg properties, but not
compatible strings i.e. ones that aren't probed independently and
aren't platform devices that I can use for reference.  I'm having a
hard time figuring out how to _easily_ obtain indexed addresses
without adding a bunch of new code.  Perhaps if we did something in
the core there would be less overhead overall? 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
