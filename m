From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 11:19:45 +0000
Subject: [PATCH v2 5/5] omap2plus: voltage: Trivial linking fix for
	'EINVAL' undeclared
In-Reply-To: <1294225024-21857-5-git-send-email-santosh.shilimkar@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110105111945.GA8717@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 04:27:04PM +0530, Santosh Shilimkar wrote:
> CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
> In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
>                  from arch/arm/mach-omap2/omap_hwmod_common_data.c:20:
> arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_late_init':
> arch/arm/plat-omap/include/plat/voltage.h:145: error: 'EINVAL' undeclared (first use in this function)
> arch/arm/plat-omap/include/plat/voltage.h:145: error: (Each undeclared identifier is reported only once
> arch/arm/plat-omap/include/plat/voltage.h:145: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-omap2/omap_hwmod_common_data.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

The correct include for this is linux/errno.h, not linux/err.h - you
want the errno definitions, not the IS_ERR/PTR_ERR/ERR_PTR stuff.
