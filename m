From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 22 Apr 2014 14:01:22 +0100
Subject: [RFC PATCH 1/2] PCI: designware: Add ARM64 PCI support
In-Reply-To: <000501cf5d48$4cf707c0$e6e51740$%han@samsung.com>
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
 <000901cf592e$563bc8c0$02b35a40$%han@samsung.com>
 <20140416165724.GG7802@e106497-lin.cambridge.arm.com>
 <16730530.rJ9T0MsYmt@wuerfel>
 <000001cf5d04$982a6000$c87f2000$%han@samsung.com>
 <000501cf5d48$4cf707c0$e6e51740$%han@samsung.com>
Message-ID: <20140422130122.GH865@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 10:58:52AM +0100, Jingoo Han wrote:
> On Monday, April 21, 2014 10:54 AM, Jingoo Han wrote:
> > On Thursday, April 17, 2014 3:26 AM, Arnd Bergmann wrote:
> > > On Wednesday 16 April 2014 17:57:24 Liviu Dudau wrote:
> > > > Jingoo,
> > > >
> > > > Thanks for taking a stab at trying to convert a host bridge
> > > > driver to use the new generic host bridge code.
> > > >
> > > > I do however have concerns on the direction you took. You have split
> > > > your driver in two, depending on whether it was CONFIG_ARM or CONFIG_ARM64,
> > > > even if (with my series) it should be no reason why the host bridge
> > > > driver should not work on other architectures as well once they are
> > > > converted.
> > >
> > > Right.
> > >
> > > > Also, some of the functions that you use have identical names but different
> > > > signatures depending on what arch you have selected. This is really bad
> > > > in my books!
> 
> [.....]
> 
> > > > What about creating functions that use my series directly if CONFIG_ARM64 is
> > > > defined (or any CONFIG_ you want to create for your driver that you select
> > > > from CONFIG_ARM64) and otherwise implement the CONFIG_ARM version? That
> > > > way your driver will call only one API without any #ifdef and when arm code
> > > > gets converted you drop your adaptation functions. Or (better yet), have a
> > > > stab at converting bios32 (Rob Herring has already provided some hints on
> > > > how to do it for arch/arm).
> > 
> > To: Liviu Dudau
> > 
> > Sorry, but I will not implement this.
> > At first, you had to think the compatibility with ARM32 PCIe.
> > Why do you want other engineers to take this load?
> 
> (+cc Rob Herring)
> 
> Um, I am looking at Rob Herring's patchset for Versatile PCI. [1]
> Then, do you mean the following?
> 
> 1. Add Rob Herring's patch converting bios32. [2]
> 2. Reference Rob Herring's patch in order to know how to
>     handle "of_create_pci_host_bridge()" directly in ARM32. [3]
> 3. Use of_create_pci_host_bridge() for the designware PCIe
>     driver in ARM32.
> 4. Also, use of_create_pci_host_bridge() for the designware PCIe
>     driver in "ARM64".
> 

Sounds like a good plan. 3 and 4 should be one and the same in my opinion, but
there might be more things in designware driver that I am missing right now.

Best regards,
Liviu

> 
> [1] http://www.spinics.net/lists/linux-pci/msg30084.html
> [2] http://www.spinics.net/lists/linux-pci/msg30083.html
> [3] http://www.spinics.net/lists/linux-pci/msg30086.html
> 
> Best regards,
> Jingoo Han
> 
> > 
> > >
> > > That would of course be best.
> > >
> 
> [.....]
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
