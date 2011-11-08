From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 8 Nov 2011 13:45:59 +0200
Subject: [PATCH v3 0/8] Add support for tegra30 and cardhu
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173F9A50F3@HQMAIL01.nvidia.com>
References: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF173F9A50F3@HQMAIL01.nvidia.com>
Message-ID: <20111108114559.GT29978@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 08:10:29PM +0100, Stephen Warren wrote:
> Peter De Schrijver wrote at Monday, November 07, 2011 7:20 AM:
> > This patchset adds support for the tegra30 SoC and the cardhu development
> > board.
> > 
> > Pathset is on top of Will Deacon's ARM reset work.
> 
> A few minor issues:
> 
> 1) If I enable just ARCH_TEGRA_3x_SOC, but not ARCH_TEGRA_2x_SOC, the
> kernel fails to build because arch/arm/mach-tegra/include/mach/irqs.h
> only defines NR_IRQS if ARCH_TEGRA_2x_SOC is defined.
> 
> 2) All the Tegra20 boards don't depend on ARCH_TEGRA_2x_SOC, so they can
> be enabled even if only Tegra30 support is enabled.
> 

Indeed. I also noticed that MACH_VENTANA lacks select MACH_SEABOARD...
Maybe I should submit a seperate patch to fix all this?

> 3) I notice that in "arm/tegra: pinmux tables and definitions for tegra30",
> you ifdef'd the two entries in tegra_pinmux_of_match[] based on which SoCs
> were enabled, but in "arm/tegra: implement support for tegra30", you didn't
> do the same for the two entries in early_init[] (board-dt.c). I'm not sure
> how far we want to take only-Tegra20 or only-Tegra30 support, but perhaps
> we should be consistent here?

Yeah. I think didn't do it for the early_init because the savings are so
small. Consistency makes sense indeed, so I will add those ifdefs.

Cheers,

Peter.
