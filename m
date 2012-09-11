From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 17:05:37 +0000
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <871ui8y3at.fsf@octavius.laptop.org>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
 <871ui8y3at.fsf@octavius.laptop.org>
Message-ID: <201209111705.37490.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Chris Ball wrote:
> On Tue, Sep 11 2012, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h
> > b/include/linux/platform_data/mmc-sdhci-tegra.h
> > similarity index 100%
> > rename from arch/arm/mach-tegra/include/mach/sdhci.h
> > rename to include/linux/platform_data/mmc-sdhci-tegra.h
> 
> Looks like you aren't renaming the idempotency guards, so e.g.
> include/linux/platform_data/mmc-sdhci-tegra.h will contain:
> 
> #ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
> #define __ASM_ARM_ARCH_TEGRA_SDHCI_H
> 
> Is that intentional?  Thanks,
> 

No, it's not intentional. We actually have a lot of instances that
are already wrong. Do we care enough to change the ones I'm moving here?

	Arnd
