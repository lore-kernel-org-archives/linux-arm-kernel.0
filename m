From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Feb 2013 18:14:18 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130207165347.GA31995@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com> <20130207153750.0fef1192@skate>
 <20130207155117.GA19666@arm.com> <20130207171904.70270598@skate>
 <20130207174040.3a345770@skate> <20130207165347.GA31995@arm.com>
Message-ID: <20130207181418.3753b007@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Murray,

On Thu, 7 Feb 2013 16:53:47 +0000, Andrew Murray wrote:

> > So in fact the problem is indeed that the subnodes pcie0,0 and pcie1,0
> > are seen as corresponding to the PCI-to-PCI bridges.
> 
> I would suggest changing the interrupt-mask to match any bus number. (Don't
> forget that the secondary bus number of each of your emulated bridges will
> vary depending on how many devices are detected underneath each root port,
> assuming you don't try and partition bus numbers or use domains between ports).

I don't think this would work. Currently, the interrupt-map associates
the interrupts with the PCI-to-PCI bridges, i.e devices 00:01, 00:02,
00:03, 00:04, 00:05, etc.

The real PCIe devices themselves are at 01:00, 02:00, 03:00, 04:00,
05:00. Each of them sit on a different bus, at devfn = 0.

So if I ignore the bus number, how could the PCI code find what is the
matching interrupt?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
