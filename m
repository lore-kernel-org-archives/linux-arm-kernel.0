From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Apr 2013 12:22:23 -0400
Subject: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
 <20130416103005.GB12726@arm.com>
 <20130417160015.777453E2B73@localhost>
 <20130417161036.GB27197@titan.lakedaemon.net>
 <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com>
Message-ID: <20130417162223.GC27197@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 05:17:48PM +0100, Grant Likely wrote:
> On Wed, Apr 17, 2013 at 5:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Wed, Apr 17, 2013 at 05:00:15PM +0100, Grant Likely wrote:
> >> On Tue, 16 Apr 2013 11:30:06 +0100, Andrew Murray <andrew.murray@arm.com> wrote:
> >> > On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
> >> > > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> >> > > property of a PCI host device, is found in both Microblaze and PowerPC
> >> > > architectures. These implementations are nearly identical. This patch
> >> > > moves this common code to a common place.
> >> > >
> >> > > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> >> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> >> > > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >> > > Acked-by: Michal Simek <monstr@monstr.eu>
> >> > > ---
> >> > >  arch/microblaze/include/asm/pci-bridge.h |    5 +-
> >> > >  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
> >> > >  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
> >> > >  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
> >> >
> >> > Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?
> >> >
> >> > I've tested that it builds on powerpc with a variety of configs (some which
> >> > include fsl_pci.c implementation). Though I don't have hardware to verify that
> >> > it works.
> >> >
> >> > I haven't tested this builds or runs on MIPS.
> >> >
> >> > You shouldn't see any difference in behaviour or new warnings and PCI devices
> >> > should continue to operate as before.
> >>
> >> I've got through a line-by-line comparison between powerpc, microblaze,
> >> and then new code. The differences are purely cosmetic, so I have
> >> absolutely no concerns about this patch. I've applied it to my tree.
> >
> > oops.  Due to the number of dependencies the mvebu-pcie series has (this
> > being one of them, we (arm-soc/mvebu) asked if we could take this
> > through our tree.  Rob Herring agreed to this several days ago.  Is this
> > a problem for you?
> >
> > It would truly (dogs and cats living together) upset the apple cart for
> > us at this stage to pipe these through a different tree...
> 
> Not a problem at all. I'll drop it.

Great!  Thanks.

Jason.
