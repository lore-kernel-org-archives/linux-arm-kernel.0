From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 12:09:36 -0600
Subject: [PATCH v7 3/5] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5390B260.2010801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 07:09 AM, Peter De Schrijver wrote:
> Implement fuse driver for Tegra20, Tegra30, Tegra114 and Tegra124.

This series isn't bisectable; building at either patch 3 or patch 4 yields:

> In file included from arch/arm/mach-tegra/fuse.c:28:0:
> arch/arm/mach-tegra/fuse.h:40:5: error: conflicting types for ?tegra_fuse_readl?
> In file included from arch/arm/mach-tegra/fuse.c:26:0:
> include/linux/tegra-soc.h:43:5: note: previous declaration of ?tegra_fuse_readl? was here
> arch/arm/mach-tegra/fuse.c:98:5: error: conflicting types for ?tegra_fuse_readl?
> In file included from arch/arm/mach-tegra/fuse.c:26:0:
> include/linux/tegra-soc.h:43:5: note: previous declaration of ?tegra_fuse_readl? was here
> make[1]: *** [arch/arm/mach-tegra/fuse.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/arm/mach-tegra] Error 2
> make: *** Waiting for unfinished jobs....
