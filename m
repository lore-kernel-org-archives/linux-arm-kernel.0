From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Sep 2011 00:01:02 +0100
Subject: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <20110908224731.GB5201@opensource.wolfsonmicro.com>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
	<3110288.bQbb0H2ME1@wuerfel>
	<1315520956.4126.3.camel@finisterre.wolfsonmicro.main>
	<20110908223720.GA21469@n2100.arm.linux.org.uk>
	<20110908224731.GB5201@opensource.wolfsonmicro.com>
Message-ID: <20110908230102.GB21469@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 03:47:31PM -0700, Mark Brown wrote:
> On Thu, Sep 08, 2011 at 11:37:20PM +0100, Russell King - ARM Linux wrote:
> 
> > With DT of course, all devices get instantiated from the device tree,
> > so there should not be any more platform specific chunks of code in
> > these locations (ha, it couldn't be solved with platform data so I
> > suspect it will continue to persist, forever unsolved.)
> 
> That's not the case at all for audio, the PCB schematic for the audio
> subsystem on a device like a smartphone is a sufficiently interesting
> piece of hardware to be a device with a driver in its own right.  The
> ASoC machine drivers aren't about instantiating devices, they are about
> controlling the interrelationships between the various devices in the
> audio subsystem.
> 
> What will happen for device tree is that there will be a device in the
> device tree for the ASoC board.

Sounds like you just solved the machine_is_xxx() problem in ASoC land too
there.  If you're _already_ going for separate devices to describe the
ASoC stuff on the board, then there's no reason that couldn't have already
been done to eliminate the machine_is_xxx() usage in ASoC - rather than
complaining about machine_is_xxx() not being a very good solution.

As I said, the problem was solved years ago, and all the component parts
have been there also for years.
