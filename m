From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 May 2012 12:39:00 -0600
Subject: [PATCH 1/1] ARM: tegra: Add Tegra Memory Controller(MC) driver
In-Reply-To: <1336063897-12083-1-git-send-email-hdoyu@nvidia.com>
References: <1336063897-12083-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <4FA2D0C4.4020608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 10:51 AM, Hiroshi DOYU wrote:
> Tegra Memory Controller(MC) driver for Tegra20/30.
> Added to support MC General interrupts, mainly for IOMMU.

> The location of a file may not be suitable because of xxx_driver under arch/arm/mach-*.
> ---
> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile

Russell, Olof, Arnd,

Where should this driver be placed? It's a completely Tegra-specific
module, and I don't believe there's any drivers/ directory or other
subsystem that's appropriate to house it right now. Should we go ahead
and create a drivers/arm/ for this? Perhaps drivers/misc/?

Honestly, to me it seems best to keep purely platform-specific drivers
like this in arch/arm/mach-tegra, since that's the most closely
Tegra-related directory.

Hiroshi,

This driver attempts to cover both Tegra20 and Tegra30. However, there's
almost no common code. I think it'd be best as separate tegra20-mc.c and
tegra30-mc.c.

This patch should include DT binding documentation.

That all said, I'd hold off on reposting this until we work out how the
MC/GART/SMMU parent-child relationship stuff is worked out; see my
immediately previous email.
