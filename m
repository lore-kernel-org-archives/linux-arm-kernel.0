From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 13:25:30 +0000
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <5049EDC8.1040406@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <20120907051917.GD10582@lunn.ch> <5049EDC8.1040406@gmail.com>
Message-ID: <201209071325.30522.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Rob Herring wrote:
> 
> On 09/07/2012 12:19 AM, Andrew Lunn wrote:
> >>> PS. A little heads-up: if this lands on 3.7, there will be conflict
> >>> on arch/arm/mach-mxs/Makefile.boot which gets new entries in this
> >>> cycle.
> >>
> >> The same is true of Tegra:
> >>
> >> -dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
> >> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a02.dtb
> >> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a04.dtb
> > 
> > Ditto kirkwood and mvebu. And Dove might also gain DT support,
> > resulting in new entries in its Makefile.boot.
> 
> It's basically scripted plus fix-up multi-line entries. We could do this
> at the end of the merge window. I don't think "make dtbs" for
> multi-platform enabled platforms being bisectable is too important.

I think I'd rather merge the series early in the merge window and
then send a follow-up later. It shouldn't hurt to add the lines
in the Makefile.boot files after this patch, right?

	Arnd
