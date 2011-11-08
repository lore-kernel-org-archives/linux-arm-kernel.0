From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 8 Nov 2011 07:56:58 -0800
Subject: [PATCH v3 0/8] Add support for tegra30 and cardhu
In-Reply-To: <20111108115153.GU29978@tbergstrom-lnx.Nvidia.com>
References: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF173F9A50F3@HQMAIL01.nvidia.com>
 <20111108114559.GT29978@tbergstrom-lnx.Nvidia.com>
 <20111108115153.GU29978@tbergstrom-lnx.Nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A5394@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, November 08, 2011 4:52 AM:
> On Tue, Nov 08, 2011 at 12:45:59PM +0100, Peter De Schrijver wrote:
> > On Mon, Nov 07, 2011 at 08:10:29PM +0100, Stephen Warren wrote:
> > > Peter De Schrijver wrote at Monday, November 07, 2011 7:20 AM:
> > > > This patchset adds support for the tegra30 SoC and the cardhu development
> > > > board.
> > > >
> > > > Pathset is on top of Will Deacon's ARM reset work.
> > >
> > > A few minor issues:
> > >
> > > 1) If I enable just ARCH_TEGRA_3x_SOC, but not ARCH_TEGRA_2x_SOC, the
> > > kernel fails to build because arch/arm/mach-tegra/include/mach/irqs.h
> > > only defines NR_IRQS if ARCH_TEGRA_2x_SOC is defined.
> > >
> > > 2) All the Tegra20 boards don't depend on ARCH_TEGRA_2x_SOC, so they can
> > > be enabled even if only Tegra30 support is enabled.
> > >
> >
> > Indeed. I also noticed that MACH_VENTANA lacks select MACH_SEABOARD...
> 
> I take that back. It's not needed.
> 
> > Maybe I should submit a seperate patch to fix all this?
> >
> 
> I will make a patch to cleanup the ARCH_TEGRA_2x_SOC dependencies. Or do you
> want this as part of the tegra30/cardhu series?

It should be applied before/with the Tegra30/Cardhu series so that when
Tegra30 support is there, all the correct dependencies are. So, since I
think you're respinning the Tegra30/Cardhu series, you may as well include
it in there somewhere, but no big deal if it's posted separately.

-- 
nvpublic
