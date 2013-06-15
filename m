From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 17:09:22 -0700
Subject: [GIT PULL] Integrator/AP PCI DT support
In-Reply-To: <20130614230838.GA18124@quad.lixom.net>
References: <CACRpkdb8J4+QH36SYavgGWbFWaBZDg5JSYyyJELzL=mSZfMnBw@mail.gmail.com>
 <20130614230838.GA18124@quad.lixom.net>
Message-ID: <20130615000922.GG18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 04:08:38PM -0700, Olof Johansson wrote:
> On Mon, Jun 03, 2013 at 01:09:17PM +0200, Linus Walleij wrote:
> > Hi ARM SoC folks,
> > 
> > here is a pull request for the Integrator/AP PCI DT support.
> > 
> > This is the final stepping stone making way for this development TODO:
> > 
> > - Preparing removal of the board files for the Integrators
> > - Multiplatform support
> > - Moving the PCIv3 driver to drivers/pci
> > 
> > The patches have been around on the lists for a long time now, only
> > waiting for the infrastructure recently added to the ARM SoC tree.
> > 
> > As you can see it is based on the of/pci-helpers branch in the ARM SoC
> > tree. I pulled this branch into my tree and rebased the patch set onto
> > this.
> > 
> > All is ACKed by Arnd except for the patch adding the function
> > pci_common_init_dev() to arch/arm/include/asm/mach/pci.h.
> > So this will be a good time for anyone who doesn't like that idea
> > to protest in the last minute.
> > 
> > Anyway: please pull it in.
> > 
> > Yours,
> > Linus Walleij
> > 
> > 
> > The following changes since commit 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:
> > 
> >   of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> > tags/integrator-pci-for-arm-soc
> 
> Pulled, apologies for the delay on this one, fell of my list of
> branches-to-pull somehow.

Hmm. integrator_defconfig no longer builds:

arch/arm/mach-integrator/pci_v3.c: In function 'pci_v3_map_irq_dt':
arch/arm/mach-integrator/pci_v3.c:835:16: error: storage size of 'oirq' isn't known
arch/arm/mach-integrator/pci_v3.c:845:2: error: implicit declaration of function 'irq_create_of_mapping'

linux/of_irq.h is already included, but it seems that CONFIG_USE_OF is off in
integrator defconfig.

What's the plan here? Making DT mandatory? Or making PCI depend on DT for this
platform?

I've dropped the branch again until resolved.


-Olof
