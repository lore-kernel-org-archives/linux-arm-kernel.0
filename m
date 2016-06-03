From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Jun 2016 09:30:42 +0200
Subject: [PATCH] PCI: mvebu: Don't try to add an MBus window that
 already exists
In-Reply-To: <57511C4E.5040501@denx.de>
References: <20160602125247.17566-1-sr@denx.de>
 <20160602151818.0989ee50@free-electrons.com>
 <57511C4E.5040501@denx.de>
Message-ID: <20160603093042.26e325d1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 3 Jun 2016 07:57:34 +0200, Stefan Roese wrote:

> > The pci-mvebu driver deletes the MBus windows for a given PCI device
> > when invalid memory base/limits are set in the emulated PCI bridge.
> > Shouldn't this happen over a rescan?  
> 
> I'm not sure what *should* happen upon rescan. But testing shows, that
> no MBus window is removed upon rescan. I just tested what happens,
> if the PCI devices are "removed" via sysfs. And this also does not
> delete any of the MBus windows.

Then maybe that's a question for the PCI folks. Is it normal that when
a PCI device gets removed, the configuration of the PCI bridge does not
get adjusted accordingly?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
