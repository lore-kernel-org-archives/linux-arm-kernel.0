From: chris.brand@broadcom.com (Chris Brand)
Date: Wed, 12 Sep 2012 16:42:31 +0000
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <201209111705.37490.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
 <871ui8y3at.fsf@octavius.laptop.org> <201209111705.37490.arnd@arndb.de>
Message-ID: <4EE5B48738DDED408878C97C8E050A8B0FAF5C@SJEXCHMB05.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You'll want to check that you don't have any cases where two files use the same guard, I'd think.

Chris

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Arnd Bergmann
Sent: September 11, 2012 10:06 AM
To: Chris Ball
Cc: Mark Brown; Russell King; Stephen Warren; Dmitry Torokhov; linux-kernel at vger.kernel.org; linux-tegra at vger.kernel.org; Colin Cross; Olof Johansson; Liam Girdwood; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 09/16] ARM: tegra: move platform_data definitions

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
