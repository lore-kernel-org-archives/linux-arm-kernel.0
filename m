From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 11 Nov 2009 17:53:53 +0100
Subject: orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!)
In-Reply-To: <200911111750.35330.dk-arm-linux@gmx.de>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111529.23176.dk-arm-linux@gmx.de>
	<20091111152134.GX18639@mail.wantstofly.org>
	<200911111750.35330.dk-arm-linux@gmx.de>
Message-ID: <20091111165353.GA22741@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 05:50:35PM +0100, Dieter Kiermaier wrote:

> 00:01.0 Class 0604: Device 11ab:2211 (rev 01)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-

The bridge has been told not to forward MEM transactions to the secondary
side, which explains what you're seeing.

It's odd that this is happening, as normally pci_enable_bridges()
takes care of enabling I/O and MEM decoding on bridges.

What other kernel patches are you using?  And can you put a full boot
log somewhere?
