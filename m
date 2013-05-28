From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 28 May 2013 12:08:59 +0100
Subject: [GIT PULL for 3.11] arm: introduce psci_smp_ops
In-Reply-To: <alpine.DEB.2.02.1305281205500.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305211522120.4799@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1305281205500.4799@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1305281208010.4799@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the noise, I have seen now that you pulled
3.10-rc2-psci-ops-11-tag into "devel-stable".

Thanks,

Stefano


On Tue, 28 May 2013, Stefano Stabellini wrote:
> ping?
> 
> 
> On Tue, 21 May 2013, Stefano Stabellini wrote:
> > Russell,
> > please pull (based on v3.10-rc2):
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git 3.10-rc2-psci-ops-11-tag
> > 
> > 
> > It contains the generic PSCI patch and the smp_init patch that we
> > discussed so much about.
> > I think it would be helpful for other people if you could create a
> > stable branch with these patches so that SoC devs can base their work on
> > it.
> > 
> > 
> > Jon Medhurst (1):
> >       ARM: Enable selection of SMP operations at boot time
> > 
> > Stefano Stabellini (1):
> >       arm: introduce psci_smp_ops
> > 
> >  arch/arm/include/asm/mach/arch.h |    5 ++
> >  arch/arm/include/asm/psci.h      |    9 ++++
> >  arch/arm/kernel/Makefile         |    5 ++-
> >  arch/arm/kernel/psci.c           |    7 +--
> >  arch/arm/kernel/psci_smp.c       |   84 ++++++++++++++++++++++++++++++++++++++
> >  arch/arm/kernel/setup.c          |    9 ++++-
> >  arch/arm/mach-virt/Makefile      |    1 -
> >  arch/arm/mach-virt/platsmp.c     |   50 ----------------------
> >  arch/arm/mach-virt/virt.c        |    3 -
> >  9 files changed, 113 insertions(+), 60 deletions(-)
> >  create mode 100644 arch/arm/kernel/psci_smp.c
> >  delete mode 100644 arch/arm/mach-virt/platsmp.c
> > 
> 
