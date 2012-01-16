From: Joerg.Roedel@amd.com (Joerg Roedel)
Date: Mon, 16 Jan 2012 12:03:32 +0100
Subject: [PATCH] ARM: OMAP3: fix build on !CONFIG_IOMMU_API
In-Reply-To: <1326288491-25146-1-git-send-email-ohad@wizery.com>
References: <1326288491-25146-1-git-send-email-ohad@wizery.com>
Message-ID: <20120116110332.GB19394@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 03:28:11PM +0200, Ohad Ben-Cohen wrote:
> omap3isp depends on CONFIG_IOMMU_API, so avoid registering its
> device (and defining its configuration structs) on !CONFIG_IOMMU_API.
> 
> This is generally nice to have, but more importantly, it fixes:
> 
> arch/arm/plat-omap/include/plat/iommu.h: In function 'dev_to_omap_iommu':
> arch/arm/plat-omap/include/plat/iommu.h:135: error: 'struct
> dev_archdata' has no member named 'iommu'
> arch/arm/mach-omap2/devices.c: In function 'omap3_init_camera':
> arch/arm/mach-omap2/devices.c:222: error: 'struct dev_archdata' has no
> member named 'iommu'
> make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Which happens because while setting up the omap3isp device we try
> to access the (now nonexistent) iommu member of dev_archdata.
> 
> Compile tested with omap2plus_defconfig on today's:

Applied. Will send pull-request soon.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
