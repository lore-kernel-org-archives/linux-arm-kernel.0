From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 25 Oct 2011 07:52:39 +0200
Subject: [PATCH] arm/tegra: Add device-tree support for TrimSlice board
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173E1B4171@HQMAIL01.nvidia.com>
References: <1319450467-11819-1-git-send-email-swarren@nvidia.com>
	<5320972.AGvAdFqRz5@ax5200p>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B4171@HQMAIL01.nvidia.com>
Message-ID: <20111025055238.GA30358@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> Marc Dietrich wrote at Monday, October 24, 2011 3:28 PM:
> > On Monday 24 October 2011 12:01:07 Stephen Warren wrote:
> > > * Add device-tree file for TrimSlice
> > > * Add that to the list of .dts files to build
> > > * Update board-dt.c to recognize TrimSlice board name
> > >
> > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > > ---
> > >  arch/arm/boot/dts/tegra-trimslice.dts |   38
> > > +++++++++++++++++++++++++++++++++ arch/arm/mach-tegra/Makefile.boot     |
> > >  1 +
> > >  arch/arm/mach-tegra/board-dt.c        |    3 ++
> > >  3 files changed, 42 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/boot/dts/tegra-trimslice.dts
> > 
> > doesn't this also require to add something like
> > 
> > obj-${CONFIG_MACH_TEGRA_DT} += board-trimslice-pinmux.o
> > 
> > to the Makefile?
> 
> Yes, definitely. I've fixed this up locally; I hope to repost soon.

Can it please be obj-$(CONFIG_MACH_TEGRA_DT) instead? I think both Russell
and Olof agreed[0] to use parens instead of braces, even though the current
practice is to copy what previous boards did.

Thierry

[0]: http://article.gmane.org/gmane.linux.ports.tegra/1670
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111025/e6ad7097/attachment-0001.sig>
