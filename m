From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Jul 2015 00:16:40 -0700
Subject: [PATCH] ARM: OMAP2+: Remove module references from IOMMU machine
 layer
In-Reply-To: <1436560985-5947-1-git-send-email-s-anna@ti.com>
References: <1436560985-5947-1-git-send-email-s-anna@ti.com>
Message-ID: <20150716071640.GI17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [150710 13:45]:
> The OMAP IOMMU driver has been adapted to the IOMMU framework
> for a while now, and it no longer supports being built as a
> module. Cleanup all the module related references both from
> the code and in the build.
> 
> While at it, also relocate a comment around the initcall to
> avoid a checkpatch strict warning about using a blank line
> after function/struct/union/enum declarations.

OK applying into omap-for-v4.3/soc.

You may want to check few things after this:

- Does it still need to be omap_subsys_initcall or can it
  happen later? Anything we can initialize later on is worth
  doing as then we have proper debug console available.

- For multi_v7_defconfig it would be nice to be able to
  make the driver/iommu components into standard Linux
  loadable modules.

- Actually you can probably get rid of mach-omap2/omap-iommu.c
  completely by implementing PM runtime and and possibly
  reset controller.

Regrds,

Tony
