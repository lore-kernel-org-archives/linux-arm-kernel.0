From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 15 Feb 2013 06:06:35 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <CAErSpo6_6bYjo5XX5tzoBfMu5Htgpa__foNCyoCnCNEHocx67Q@mail.gmail.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo6_6bYjo5XX5tzoBfMu5Htgpa__foNCyoCnCNEHocx67Q@mail.gmail.com>
Message-ID: <20130215060635.43f06f71@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Thu, 14 Feb 2013 17:36:39 -0700, Bjorn Helgaas wrote:

> > +config PCI_MVEBU
> > +       bool "Marvell EBU PCIe controller"
> > +       depends on ARCH_MVEBU
> > +       select PCI_SW_HOST_BRIDGE
> > +       select PCI_SW_PCI_PCI_BRIDGE
> 
> I think PCI_SW_HOST_BRIDGE and PCI_SW_PCI_PCI_BRIDGE are obsolete and
> can be removed, right?

Indeed, will fix.


> > +       case PCI_PREF_LIMIT_UPPER32:
> > +               bridge->preflimitupper = value;
> > +               break;
> 
> You're relying on a subsequent PCI_COMMAND write to set PCI_COMMAND_IO
> and/or PCI_COMMAND_MEMORY, and you program the bridge windows at that
> time.

Correct.

>  It might be a good idea if the PCI core did clear those bits
> while updating the windows, but I'm not sure we do.  In any case,
> delaying the update is a difference from a standard P2P bridge that
> could cause issues later.

When would you want the window assignment to occur? Directly when the
registers containing the base/limit are being written to? There are
multiple registers for base/limit, so I'll have to figure out a way to
validate when the base/limit informations are valid.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
