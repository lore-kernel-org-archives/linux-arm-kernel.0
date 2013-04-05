From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Apr 2013 09:30:27 +0900
Subject: [RFC/PATCH 0/7] ARCH: shmobile: defconfig consolidation
In-Reply-To: <1374328.KVLKlOlad0@avalon>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
 <1374328.KVLKlOlad0@avalon>
Message-ID: <20130405003027.GB29203@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 01:20:44PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 04 April 2013 12:29:46 Simon Horman wrote:
> > Hi,
> > 
> > this is a first pass at consolidating the defconfigs of shmobile.
> > 
> > It covers the mackerel, amradillo800eva and kzm9d boards which meet
> > the following criteria:
> > 
> > * Have the same base memory address (0x40000000).
> 
> Do you know if there's any work being done on getting rid of the base memory 
> address as a kernel config option ? It seriously hinders cross-SoC kernel 
> testing.

As I understand things the main limitation is uImage which uses
the base memory address. There is some talk of creating uImages
at install time rather than build time. Which I believe would
remove most if not all the problem. However, its entirely unclear
to me what such an install process would look like. A new build target?
In tree script? Out of tree script? It seems very undefined to me.

Another, arguably better though not backwards compatible, option
is to boot using zImage (or even just Image) which do not rely
on the base address.

I'm not aware of any other work or discussion in this area although
it would not surprise me if there was some.

> > * Work with RUNTIME_PM, it is desirable to have that a common defconfig
> > * Are booted via DT, enabling the command line to be supplied in the dts.
> >   This is important to allow serial console and early printk settings,
> >   which vary wildly between boards, to be supplied.
> > * Boards I have to test.
> >   This didn't eliminate any candidates that met the above criteria.
> > 
> > I believe it should also be possible to add support for the APE6EVM
> > board to the consolidated defconfig once problems with RUNTIME_PM
> > have been isolated and resolved. I have send an email about this
> > in a separate thread "APE6EVM and Runtime PM".
> > 
> > I believe it may be possible to add support for the lager board
> > to the consolidated defconfig once I am able to bring that board up,
> > which should be rather soon. The lager board does not currently
> > have a defconfig.
> > 
> > Morimoto-san, I suspect it may be possible to add support for the
> > bockw board to the consolidated defconfig if its boot loader supports
> > booting using a zImage. In this case even though the base memory address
> > is not the same as the boards above it should be possible to specify
> > the base address from the boot loader. As I do not have a bockw board
> > I am wondering if you could investigate this.
> > 
> > Simon Horman (7):
> >   ARM: shmobile: prune defconfig
> >   ARM: shmobile: make defconfig canonical
> >   ARM: shmobile: Add kzm9d to consolidated defconfig
> >   ARM: shmobile: Add mackerel to consolidated defconfig
> >   ARM: shmobile: defconfig: Remove armadillo800eva defconfig
> >   ARM: shmobile: defconfig: Remove kzm9d defconfig
> >   ARM: shmobile: defconfig: Remove mackerel defconfig
> > 
> >  arch/arm/configs/armadillo800eva_defconfig |  153 -------------------------
> >  arch/arm/configs/kzm9d_defconfig           |   88 ----------------
> >  arch/arm/configs/mackerel_defconfig        |  156 -------------------------
> >  arch/arm/configs/shmobile_defconfig        |   51 +++++----
> >  4 files changed, 28 insertions(+), 420 deletions(-)
> >  delete mode 100644 arch/arm/configs/armadillo800eva_defconfig
> >  delete mode 100644 arch/arm/configs/kzm9d_defconfig
> >  delete mode 100644 arch/arm/configs/mackerel_defconfig
> -- 
> Regards,
> 
> Laurent Pinchart
> 
