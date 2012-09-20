From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Sep 2012 15:11:56 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <201209201327.45802.arnd@arndb.de>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1209201240110.29232@kaball.uk.xensource.com>
 <1348143533.26501.28.camel@zakaz.uk.xensource.com>
 <201209201327.45802.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1209201501140.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012, Arnd Bergmann wrote:
> On Thursday 20 September 2012, Ian Campbell wrote:
> > On Thu, 2012-09-20 at 12:56 +0100, Stefano Stabellini wrote:
> > > On Thu, 20 Sep 2012, Ian Campbell wrote:
> > > > On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> 
> > > > > + compatible = "xen,xenvm-4.2", "arm,vexpress";
> > > > 
> > > > Is this second compatible thing actually true? We don't actually emulate
> > > > much (anything?) of what would be on a real vexpress motherboard.
> > > > 
> > > > "arm,vexpress" is used only in v2m.c and I don't think we want the
> > > > majority of that -- we don't provide any of the peripherals which it
> > > > registers.
> > > > 
> > > > I think the only things we might want out of that lot are the arch timer
> > > > and perhaps the uart0 (as a debug port).
> > > > 
> > > > I suspect we should have our own xen machine .c.
> > > > 
> > > > [...]
> > > 
> > > It is true that we are "arm,vexpress" compatible at the moment.
> > 
> > But we aren't, we don't emulate 90%+ of the actual hardware which
> > vexpress compatibility would actually imply.
> > 
> > Look in arch/arm/mach-vexpress/v2m.c, which is the only thing keyed off
> > this compat value -- it's full of stuff which we don't (and aren't going
> > to) implement.
> 
> It's not much different in the end, but I think I'd rather make the
> compatible list in the device tree "xen,xenvm-4.2", "xen,xenvm" without
> listing "arm,vexpress", but then adding "xen,xenvm" to the list of
> compatible devices in the vexpress kernel code.
> 
> The main difference is that if we decide to separate out the Linux
> code for Xen and vexpress later into distinct ports, we have the
> option to do that. vexpress will support multiplatform configurations
> in 3.7 anyway, so the idea of making all virtual platforms part of
> vexpress in order to be able to boot the same kernel on them is not
> all that important any more.

That's a very good idea, I'll do that.
