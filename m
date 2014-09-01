From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 22:18:26 +0200
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <20140901164000.GM24594@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <3729116.F0gWrQGFZl@wuerfel> <20140901164000.GM24594@arm.com>
Message-ID: <4335091.FB685Z52eG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 17:40:00 Will Deacon wrote:
> On Mon, Sep 01, 2014 at 03:46:18PM +0100, Arnd Bergmann wrote:
> > On Monday 01 September 2014 10:29:40 Thierry Reding wrote:
> > > 
> > > I think this could use a bit more formalization. As I said in another
> > > reply earlier, there's very little standardization in the IOMMU API.
> > > That certainly gives us a lot of flexibility but it also has the
> > > downside that it's difficult to handle these abstractions in the core,
> > > which is really what the core is all about, isn't it?
> > > 
> > > One method that worked really well for this in the past for other
> > > subsystems is to allow drivers to specify an .of_xlate() function that
> > > takes the controller device and a struct of_phandle_args. It is that
> > > function's responsibility to take the information in an of_phandle_args
> > > structure and use that to create some subsystem specific handle that
> > > represents this information in a way that it can readily be used.
> > 
> > Yes, good idea.
> 
> Hmm, how does this work for PCI devices? The current RFC takes care to
> ensure that the core changes work just as well for OF devices as PCI
> devices, and the of-specific functions and data structures are not part of
> it.

I don't mind handling PCI devices separately. They are different in a number
of ways already, in particular the way that they don't normally have an
of_node attached to them but actually have a PCI bus/dev/function number.

	Arnd
