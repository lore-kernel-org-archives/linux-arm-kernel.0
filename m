From: mbizon@freebox.fr (Maxime Bizon)
Date: Fri, 13 Nov 2009 15:35:56 +0100
Subject: [PATCH] ARM: enable PCI bridges after assigning resources (was
	orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell stock
	2.6.22.18 works!))
In-Reply-To: <20091112195647.GH22741@mail.wantstofly.org>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111750.35330.dk-arm-linux@gmx.de>
	<20091111165353.GA22741@mail.wantstofly.org>
	<200911111811.07413.dk-arm-linux@gmx.de>
	<20091111171916.GC22741@mail.wantstofly.org>
	<1257989709.3918.8.camel@kero>
	<20091112195647.GH22741@mail.wantstofly.org>
Message-ID: <1258122956.2926.110.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2009-11-12 at 20:56 +0100, Lennert Buytenhek wrote:

> As normal devices aren't enabled (in the MEM/IO decoding sense) by
> default on boot either, I wonder if we should just have pci_enable_device()
> walk through the PCI tree up to the root, enabling each of the bridges
> on its path?

My patch is what (at least) MIPS pci code does, but your solution sounds
fine too.

-- 
Maxime
