From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 16:58:13 +0200
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB26904.1060308@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
 <4FB26904.1060308@codethink.co.uk>
Message-ID: <20120515165813.66b4434e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 15:32:36 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> Yes, the number of times I've viewed the kernel and seen very similar
> code replicated multiple times tends to make me burst into tears.
> 
> >   * Maybe those mappings can be done using a normal ioremap() rather
> >     than in ->map_io(), according to DT informations (but most
> > other ARM SoC support at the moment seem to do PCI mappings using
> > static mappings in ->map_io)
> 
> That's a very old way of doing it. I'm pretty sure there's no reason
> to get these allocated so early.
> 
> I believe you can probably leave the PCI/PCIe bindings until you have
> enough kernel state to do ioremap() or similar and then associate the
> necessary mappings with the bus creation.

Agreed. When looking at the code, I wasn't sure why PCI mappings were
needed so early. Surely, the minimal mappings to get an UART are quite
useful to have very early, but why PCI?

> >   * We probably shouldn't have anticipated this too much, and keep
> > only one file for this initial submission.
> 
> Yes, the less we need to review the better.

We've tried to minimize as much as possible the amount of code for this
initial submission. We already have some code for PCI, L2 cache
support, network driver, etc, but we wanted to limit ourselves to the
strict minimum to get a kernel booting with an initramfs based root
filesystem.

> > Thanks for the comments!
> 
> I'll get to testing this kernel soon, and report back

Excellent, thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
