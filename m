From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Oct 2013 16:22:05 +0200
Subject: Arm PCIe hotplugging
In-Reply-To: <20131004135345.GA31178@titan.lakedaemon.net>
References: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
 <20131004135345.GA31178@titan.lakedaemon.net>
Message-ID: <20131004162205.7a6f516f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 4 Oct 2013 09:53:45 -0400, Jason Cooper wrote:

> Please Cc: the relevant maintainers, it helps us pick out emails needing
> our attention out of the noise ;-)  I've added them to this reply.

True!

> > I have been doing some work with an Armada XP board (DB-MV784MP-GP)
> > with PCIe support, along with using a PEX 8614 (AA) PCIe switch. The
> > switch in question is said to have hot plug support with the PCIe
> > downstream slots.
> > 
> > However using both the generic "pcieport" and the proprietary kernel
> > module used by PLX (this took some work to run on an ARM board and is
> > very buggy on the platform buggy so the generic in tree drivers are
> > preferable) the /sys/bus/pci/slots/ directory is always empty and
> > /sys/bus/pci/rescan seems to do nothing.
> > 
> > Looking closer it seems that in the ARM kernel the PCI hotplug code is
> > all disabled. Am I just out of luck and should wait until there is a
> > new driver for the PCI switch's hot plug controller and a general hot
> > plug framework for ARM or is there some kind of work around?

I known Jason Gunthorpe has gotten hotplug to work on Kirkwood with the
PCIe driver that is also used for Armada 370/XP (which in fact we
originally wrote for 370/XP). I'll let him answer you, but I guess you
would need to provide a few more details (lspci outputs, etc.).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
