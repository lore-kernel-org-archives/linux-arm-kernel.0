From: acolin@isi.edu (Alexei Colin)
Date: Thu, 2 Aug 2018 09:45:44 -0400
Subject: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
Message-ID: <20180802134544.GG38497@guest228.east.isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 10:57:00AM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 1, 2018 at 3:16 PM Alex Bounine <alex.bou9@gmail.com> wrote:
> > On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> > > On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> > >> Platforms with a PCI bus will be offered the RapidIO menu since they may
> > >> be want support for a RapidIO PCI device. Platforms without a PCI bus
> > >> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> > >> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> > >>
> > >> Tested that kernel builds for arm64 with RapidIO subsystem and
> > >> switch drivers enabled, also that the modules load successfully
> > >> on a custom Aarch64 Qemu model.
> > >
> > > As said before, please include it from drivers/Kconfig so that _all_
> > > architectures supporting PCI (or other Rapidio attachements) get it
> > > and not some arbitrary selection of architectures.
> 
> +1
> 
> > As it was replied earlier this is not a random selection of
> > architectures but only ones that implement support for RapidIO as system
> > bus. If other architectures choose to adopt RapidIO we will include them
> > as well.
> >
> > On some platforms RapidIO can be the only system bus available replacing
> > PCI/PCIe or RapidIO can coexist with PCIe.
> >
> > As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or
> > "Bus Support" (ARMs) sub-menu and from system configuration option it
> > should be kept this way.
> >
> > Current location of RAPIDIO configuration option is familiar to users of
> > PowerPC and x86 platforms, and is similarly available in some ARM
> > manufacturers kernel code trees.
> >
> > drivers/Kconfig will be used for configuring drivers for peripheral
> > RapidIO devices if/when such device drivers will be published.
> 
> Everything in drivers/rapidio/Kconfig depends on RAPIDIO (probably it should
> use a big if RAPIDIO/endif instead), so it can just be included from
> drivers/Kconfig now.
> 
> The sooner you do that, the less treewide changes are needed (currently
> limited to mips, powerpc, and x86; your patch adds arm64).

If I move RapidIO option to drivers/Kconfig, then it won't appear under
the Bus Options/System Support menu, along with other choices for the
system bus (PCI, PCMCIA, ISA, TC, ...). Alex explains above that RapidIO
may be selected as a system bus on some architectures, and users expect
it to be in the menu in which it has been for some time now.  What
problem is the current organization causing?

This patch does not intend to propose any changes to the current
organization of the menus, if such changes are needed, another patch can
be made with that purpose. What problem is this patch introducing?
