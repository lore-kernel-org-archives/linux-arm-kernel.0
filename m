From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 19:21:54 +0200
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device
 tree nodes
In-Reply-To: <201306181918.59046.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181829.35514.arnd@arndb.de> <20130618191535.44fe595c@skate>
 <201306181918.59046.arnd@arndb.de>
Message-ID: <20130618192154.4c1530cc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 18 Jun 2013 19:18:58 +0200, Arnd Bergmann wrote:

> > >                        ranges =
> > >                               <0x82000000 0 0x40000    0xffff0001 0x40000 0 0x00002000
> > >                                0x82000000 0 0x80000    0xffff0001 0x80000 0 0x00002000
> > >                                0x82000000 1 0 MBUS_ID(0x12, 0x34) 0  1 0
> > >                                0x82000000 2 0 MBUS_ID(0x13, 0x34) 0  1 0
> > >                                0x81000000 1 0 MBUS_ID(0x12, 0x35) 0 0 0x10000;
> > >                                0x81000000 2 0 MBUS_ID(0x13, 0x35) 0 0 0x10000>;
> > > 
> > > The MBUS_ID numbers above are made up since I don't know them, but this way you can
> > > describe how the entire 4GB MMIO address space of the PCI bus is mapped into the
> > > MBUS address space.
> > 
> > This is NOT possible because we don't know in advance how much memory
> > space and I/O space each PCIe device will require.
> > 
> > Arnd, we've discussed this at length with you while getting the PCIe
> > driver merged, and we've explained this to you numerous times. Could
> > you please understand that any of your proposal that suggests writing
> > down static windows for PCIe devices will not work?
> 
> Where did I suggest static windows for PCIe devices?

Where does your new proposal buys us anything useful compared to the
existing PCIe DT binding that has been discussed at length with you?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
