From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Aug 2012 10:14:07 +0100
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <CAOesGMiWuqqprQ8GGzAgpFNE7k=qvPJpsx7MiVv2CKsSqyiQiw@mail.gmail.com>
References: <50049285.1060100@gmail.com> <50130F36.4090902@gmail.com>
 <CAOesGMiWuqqprQ8GGzAgpFNE7k=qvPJpsx7MiVv2CKsSqyiQiw@mail.gmail.com>
Message-ID: <20120814091407.GB26070@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 12:07:56AM +0100, Olof Johansson wrote:
> > On 07/16/2012 05:15 PM, Rob Herring wrote:
> > The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:
> >
> >   Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)
> >
> > are available in the git repository at:
> >
> >   git://sources.calxeda.com/kernel/linux.git io-cleanup-pci-v2
> 
> I have replaced the current staging/io-cleanup-pci contents with the
> above branch. Ideally I'd like to see a fix to the issues on
> integrator before we send it up though.

I *finally* got to the bottom of the issues I was seeing on my integrator
board with these patches. The ATX PSU I was using doesn't have a thumping
great resistor across it and, since the board draws very little current, the
voltage is all over the shop. Of the 3 PCI slots, this made one completely
unusable, one slightly temperamental and the other `rock solid'.

I was using the temperamental slot and the probing of the VGA console
combined with the later PCI initialisation somehow pushes it over the edge
and locks up the board. Swapping the PSU for one with an artifical load
across it makes all of the slots jump into life.

Late in the day, but I worked for this!:

Tested-by: Will Deacon <will.deacon@arm.com>

Will
