From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Jan 2016 11:10:28 +0100
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <20160121094832.GA22037@shlinux2>
References: <4405270.vcz87Q878u@wuerfel> <1989217.907WTZoGvq@wuerfel>
 <20160121094832.GA22037@shlinux2>
Message-ID: <3851350.Ox9dssDdWY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2016 17:48:32 Peter Chen wrote:
> 
> > 
> > So two hubs at ports 1 and 2 of the USB controller that integrates
> > the root hub and shares a device node with it.
> > 
> Ok, so the "reg" is the address for certain root hub (HS or SS), not
> the unity address for the whole controller, if it is, do we really
> need to add two nodes for one physical port, HS and SS will not be used
> at the same time. And if the reg is the same, how can we know
> which node is from current recognized device.

The "reg" is the address that the parent device uses to talk to the child
device. If you know which of the two that child is attached to, then I
think you don't need both, but I think we have to use the entire addressing.

In Alan's example, there are six HS ports and three SS ports, but as I
understand it, there is no guarantee that the numbering between the two
is identical, and that the three SS ports always refer to the three HS
ports. In particular for devices soldered on-board (rather than connected
through a standard plug), I would guess that it is possible to connect
them to separate child devices though I have to admit that I do not
understand enough of the standard to know for sure.

	Arnd
