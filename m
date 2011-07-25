From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Jul 2011 23:13:01 +0200
Subject: [PATCH 1/2] ARM: tegra: only select
	MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF52B@HQMAIL01.nvidia.com>
References: <1311608874-31863-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDF52B@HQMAIL01.nvidia.com>
Message-ID: <20110725211301.GM16561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 09:14:49AM -0700, Stephen Warren wrote:
> Uwe Kleine-K?nig wrote at Monday, July 25, 2011 9:48 AM:
> > This fixes:
> > 	warning: (MACH_HARMONY && MACH_KAEN && MACH_SEABOARD) selects MACH_HAS_SND_SOC_TEGRA_WM8903
> > which has unmet direct dependencies (SOUND && !M68K && SND && SND_SOC)
> 
> > diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> ...
> >  config MACH_HARMONY
> >         bool "Harmony board"
> > -       select MACH_HAS_SND_SOC_TEGRA_WM8903
> > +       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC
> 
> Shouldn't that be SND_SOC?
Hmm, with SOUND_SOC the warning is gone, too :-)

Yeah, will send a fixed patch tomorrow.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
