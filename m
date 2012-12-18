From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 18 Dec 2012 13:32:45 +0000
Subject: [Xen-devel] [PATCH v2 5/6] ARM: Dummy Virtual Machine platform
 support
In-Reply-To: <20121218131401.GB22139@mudshark.cambridge.arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-6-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.02.1212181202310.17523@kaball.uk.xensource.com>
 <20121218131401.GB22139@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1212181332010.17523@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Dec 2012, Will Deacon wrote:
> Hi Stefano,
> 
> On Tue, Dec 18, 2012 at 12:04:38PM +0000, Stefano Stabellini wrote:
> > On Mon, 17 Dec 2012, Will Deacon wrote:
> > > From: Marc Zyngier <marc.zyngier@arm.com>
> > > 
> > > Add support for the smallest, dumbest possible platform, to be
> > > used as a guest for KVM or other hypervisors.
> > > 
> > > It only mandates a GIC and architected timers. Fits nicely with
> > > a multiplatform zImage. Uses very little silicon area.
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/Kconfig            |  2 ++
> > >  arch/arm/Makefile           |  1 +
> > >  arch/arm/mach-virt/Kconfig  |  9 +++++++
> > >  arch/arm/mach-virt/Makefile |  5 ++++
> > >  arch/arm/mach-virt/virt.c   | 65 +++++++++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 82 insertions(+)
> > >  create mode 100644 arch/arm/mach-virt/Kconfig
> > >  create mode 100644 arch/arm/mach-virt/Makefile
> > >  create mode 100644 arch/arm/mach-virt/virt.c
> > 
> > Should it come along with a DTS?
> 
> The only things the platform needs are GIC, timers, memory and a CPU.
> Furthermore, the location, size, frequency etc properties of these aren't
> fixed, so a dts would be fairly useless because it will probably not match
> the particular mach-virt instance you're targetting.
> 
> For kvmtool, I've been generating the device-tree at runtime based on how
> kvmtool is invoked and it's been working pretty well so far.

I agree on the fact that it should be generated, but I personally think
that it would still be useful as an example.
