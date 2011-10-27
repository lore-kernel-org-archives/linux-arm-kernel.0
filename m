From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 21:16:57 +0100
Subject: [PATCH 3/6] arm/tegra: prepare early init for multiple tegra
	variants
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173E1B49B2@HQMAIL01.nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-4-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B49B2@HQMAIL01.nvidia.com>
Message-ID: <20111027201657.GP19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:06:13PM -0700, Stephen Warren wrote:
> Peter De Schrijver wrote at Tuesday, October 25, 2011 10:54 AM:
> > -static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
> > +void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
> 
> I'm not sure why you moved that, but I suppose it's fine.

Note that Nicolas has a patch set during KS which cleans the arch_reset
business out of mach/system.h, and effectively gets rid of arch_reset
entirely, so this probably conflicts with those changes.
