From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 12:34:59 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <20130322121218.GD4977@n2100.arm.linux.org.uk>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303221152.07569.arnd@arndb.de>
 <20130322121218.GD4977@n2100.arm.linux.org.uk>
Message-ID: <201303221234.59289.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Russell King - ARM Linux wrote:
> > Also, in many cases, you don't even have the choice in the kernel between
> > the two options, either PCI is identity mapped or mapped starting at
> > address zero based on whatever the soc or board designer thought, and the
> > only thing we can do is tell the kernel what the hardware does.
> 
> Exactly which is why you're wrong. :)  If the hardware enforces a
> separation of the physical address space from the PCI address space
> by way of an offset translation, then you have no option but to have
> a non-zero mem_offset.

I still think we are in complete agreement about the facts here, at least
I was trying to say the same thing above that you replied with.

> > It looks like cns3xxx, tegra, versatile and ks8695 are all hardwired to a
> > zero mem_offset, while dc21285, integrator, it8152 and sa1100/pci-nanoengine
> > map the PCI bus starting at bus address 0.
> 
> Don't read too much into the versatile stuff.  All that is very very much
> untested and fragile.  It's fairly buggered at the moment as it stands,
> and as far as I can tell there's absolutely no way to know what the right
> solution is - because the ARM documentation is extremely poor and all the
> real hardware has been stuffed through the mincer.
> 
> So that leaves cns3xxx, tegra and ks8695 being the non-plat ones which
> are "different" from the majority on ARM.

Well, those and all the ones that chose to set up their windows in the
same way like the plat-orion based ones.

	Arnd
