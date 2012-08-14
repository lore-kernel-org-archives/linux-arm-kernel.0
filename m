From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Aug 2012 09:37:46 +0000
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <20120814091407.GB26070@mudshark.cambridge.arm.com>
References: <50049285.1060100@gmail.com>
 <CAOesGMiWuqqprQ8GGzAgpFNE7k=qvPJpsx7MiVv2CKsSqyiQiw@mail.gmail.com>
 <20120814091407.GB26070@mudshark.cambridge.arm.com>
Message-ID: <201208140937.46974.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Will Deacon wrote:
> On Mon, Jul 30, 2012 at 12:07:56AM +0100, Olof Johansson wrote:
> > > On 07/16/2012 05:15 PM, Rob Herring wrote:
> > > The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:
> > >
> > >   Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)
> > >
> > > are available in the git repository at:
> > >
> > >   git://sources.calxeda.com/kernel/linux.git io-cleanup-pci-v2
> > 
> > I have replaced the current staging/io-cleanup-pci contents with the
> > above branch. Ideally I'd like to see a fix to the issues on
> > integrator before we send it up though.
> 
> I finally got to the bottom of the issues I was seeing on my integrator
> board with these patches. The ATX PSU I was using doesn't have a thumping
> great resistor across it and, since the board draws very little current, the
> voltage is all over the shop. Of the 3 PCI slots, this made one completely
> unusable, one slightly temperamental and the other `rock solid'.
> 
> I was using the temperamental slot and the probing of the VGA console
> combined with the later PCI initialisation somehow pushes it over the edge
> and locks up the board. Swapping the PSU for one with an artifical load
> across it makes all of the slots jump into life.
> 
> Late in the day, but I worked for this!:
> 
> Tested-by: Will Deacon <will.deacon@arm.com>

Just to let you know, I've started getting the arm-soc tree into shape
for v3.7, and the series is now scheduled for integration in the next
merge window as a regular branch.

	Arnd
