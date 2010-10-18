From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Oct 2010 17:23:14 +0200
Subject: [PATCH 0/7] arm/versatile PCI support, second try
In-Reply-To: <000001cb6ea2$1b78ccd0$526a6670$@tuckley@arm.com>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
	<AANLkTikc5Vc0Q0z4rE4raX7LTyB=LiE+YuzycMjsXUaM@mail.gmail.com>
	<000001cb6ea2$1b78ccd0$526a6670$@tuckley@arm.com>
Message-ID: <201010181723.14462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 October 2010, Colin Tuckley wrote:
> > > With lots of help and testing from Peter Maydell, I've completed
> > > a second version of the PCI support for the versatile platform,
> > > which works much better now on real hardware, although it does
> > > not improve existing qemu setups.
> > 
> > I've got nothing better to do tonite than playing with the PB1176
> > board so tried this out...
> 
> Note that the PB1176 and EB are in mach-realview rather than mach-versatile
> like the PB926. This complicates the PCI side of things since the other
> boards in mach-realview have a different PCI implementation (via a NEC
> custom Northbridge chip).

Yes, I know that. All of them use plat-versatile though, which is where
the common code sits.

All the code I added is either specific to the xilinx PCI implementation
or specific to one of the boards (pb926, pb1176, eb).

> I am just about to push the PCI code patches for these boards (PBA8,
> PB11MPCore and PBX) to the list.

I don't expect any conflicts besides my patch 5/7, which will get obsoleted
by your patch. If you apply both series, we should be able to enable
both Xilinx and NEC PCI support on mach-realview and have it work
on all the boards.

	Arnd
