From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 30 Jan 2014 17:15:49 +0000
Subject: [PATCH] arm: document "mach-virt" platform.
In-Reply-To: <52EA83D6.9050506@codeaurora.org>
References: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
 <52EA83D6.9050506@codeaurora.org>
Message-ID: <1391102149.9495.39.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-30 at 11:54 -0500, Christopher Covington wrote:
> > +++ b/Documentation/devicetree/bindings/arm/mach-virt.txt
> > @@ -0,0 +1,32 @@
> > +* Mach-virt "Dummy Virtual Machine" platform
> > +
> > +"mach-virt" is the smallest, dumbest platform possible, to be used as
> > +a guest for Xen, KVM and other hypervisors.
> 
> The platform is also useful to, and used by, simulators like QEMU in TCG mode.

I can mention this, although I don't think the list needs to be
exhaustive.
                                      It has no
> > +properties/functionality of its own and is driven entirely by device
> > +tree.
> 
> I find this wording confusing. I read it as saying the platform has no
> properties or functionality. Perhaps you could phrase it slightly differently,
> such as having no properties or functionality beyond what's described in the
> device tree.

Yes, this is what I was trying to say, I'll update with something along
those lines.

> > +The platform may also provide hypervisor specific functionality
> > +(e.g. PV I/O), if it does so then this functionality must be
> > +discoverable (directly or indirectly) via device tree.
> 
> I think it would be informative to provide pointers here to commonly used
> paravirtualized devices, especially VirtIO PCI/MMIO.

Under what criteria would something be eligible/appropriate to be
listed? I was trying to avoid "advocating" any particular type of PV
devices. We already have something of a problem with people incorrectly
assuming that mach-virt == virtio, which is not the case.

If we did want to include an explicit list here at a minimum I would
also want to include the Xen PV devices as well and surely there would
be others which ought to be included too.

Ian.
