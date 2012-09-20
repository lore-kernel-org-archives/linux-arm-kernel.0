From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Sep 2012 13:15:07 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348142133.11116.109.camel@hornet>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348135563.11116.94.camel@hornet>
 <alpine.DEB.2.02.1209201235450.29232@kaball.uk.xensource.com>
 <1348142133.11116.109.camel@hornet>
Message-ID: <alpine.DEB.2.02.1209201308490.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012, Pawel Moll wrote:
> On Thu, 2012-09-20 at 12:39 +0100, Stefano Stabellini wrote:
> > There are no peripherals apart from the ones that are already described
> > here (timer, gic). All the peripherals that the guest sees are virtual
> > devices that show up on xenbus (a virtual bus). In order to initialize
> > xenbus, the guest only needs the hypervisor node.  So I'll remove the
> > ranges and interrupt-map.
> 
> So all the peripherals are actually discoverable - awesome!
> 
> But the fact is that the only "vexpressness" of this tree is
> memory at 80000000 and gic at 2c001000. The rest (not much of it ;-) is a
> "generic A15 platform". 
> 
> I understand that you had to use some "compatible" value to get
> initialization code and I'm flattered ;-) by your choice of
> "arm,vexpress", but maybe - as suggested by others - you would be better
> off with generating this stuff in runtime, by whatever tool is used to
> instantiate the guest?

Yes, it is certainly going to be generated at run time. Does it make
sense to keep an example under arch/arm/boot/dts? I think so. There must
be other platforms that actually pass the device tree to the kernel from
the firmware and still have a dts in the kernel tree, right?
If actually there are none, it is probably best to forget about this
patch :)

Regarding the choice of "arm,vexpress", there was a discussion at kernel
summit about vexpress being the right choice as a base platform for
virtual machines on ARM, even though in the Xen case it means having a
vexpress with no peripherals.
