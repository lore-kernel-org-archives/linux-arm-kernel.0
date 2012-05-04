From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 4 May 2012 15:00:35 +0200
Subject: [PATCH 1/1] ARM: tegra: Add Tegra Memory Controller(MC) driver
In-Reply-To: <4FA2D0C4.4020608@wwwdotorg.org>
References: <1336063897-12083-1-git-send-email-hdoyu@nvidia.com><4FA2D0C4.4020608@wwwdotorg.org>
Message-ID: <20120504.160035.1828735037330038337.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/1] ARM: tegra: Add Tegra Memory Controller(MC) driver
Date: Thu, 3 May 2012 20:39:00 +0200
Message-ID: <4FA2D0C4.4020608@wwwdotorg.org>

> On 05/03/2012 10:51 AM, Hiroshi DOYU wrote:
> > Tegra Memory Controller(MC) driver for Tegra20/30.
> > Added to support MC General interrupts, mainly for IOMMU.
> 
> > The location of a file may not be suitable because of xxx_driver under arch/arm/mach-*.
> > ---
> > diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> 
> Russell, Olof, Arnd,
> 
> Where should this driver be placed? It's a completely Tegra-specific
> module, and I don't believe there's any drivers/ directory or other
> subsystem that's appropriate to house it right now. Should we go ahead
> and create a drivers/arm/ for this? Perhaps drivers/misc/?
> 
> Honestly, to me it seems best to keep purely platform-specific drivers
> like this in arch/arm/mach-tegra, since that's the most closely
> Tegra-related directory.
> 
> Hiroshi,
> 
> This driver attempts to cover both Tegra20 and Tegra30. However, there's
> almost no common code. I think it'd be best as separate tegra20-mc.c and
> tegra30-mc.c.
> 
> This patch should include DT binding documentation.
> 
> That all said, I'd hold off on reposting this until we work out how the
> MC/GART/SMMU parent-child relationship stuff is worked out; see my
> immediately previous email.

Ok.

What about the following AHB patches? AHB patches are independent of
MC/GART/SMMU DT issue basically. If you think that they are ready to
merge, I'll post the update version, I fixed some of your latest
comments.

 [PATCH 1/3] ARM: tegra: Add Tegra AHB driver
 [PATCH 2/3] ARM: tegra: Add SMMU enabler in AHB
 [PATCH 3/3] ARM: dt: tegra: Add device tree support for AHB


I'll hold off on the following until we get some direction for
MC/GART/SMMU. They are related to how dt info is passed via MC.

 [PATCH 1/3] ARM: tegra: Add Tegra Memory Controller(MC) driver
 [PATCH 2/3] ARM: dt: tegra: Add device tree support for Memory Controller(MC)
 [PATCH 3/3] iommu/tegra: smmu: Refrain from accessing to AHB
