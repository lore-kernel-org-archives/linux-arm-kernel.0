From: khilman@ti.com (Kevin Hilman)
Date: Mon, 10 Oct 2011 11:01:59 -0700
Subject: [PATCH 00/24 V2] OMAP4: PM: suspend,
	CPU-hotplug and CPUilde support
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 24 Sep 2011 11:44:20 +0530")
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87ty7ghgiw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
> suspend (S2R), CPU hotplug and CPUidle.

There are a few more compile errors when doing OMAP1-only builds.
You'll need a way to eliminate the secure calls for OMAP1.

This series causes a couple build errors when doing OMAP1-only builds
(I used omap1_defconfig):

First:

/work/kernel/omap/pm/arch/arm/plat-omap/common.c:24:30: fatal error: mach/omap-secure.h: No such file or directory

And trying creating a dummy header to see if it would continue to build gives:

/work/kernel/omap/pm/arch/arm/plat-omap/common.c: In function 'omap_reserve':
/work/kernel/omap/pm/arch/arm/plat-omap/common.c:70:2: error: implicit declaration of function 'omap_secure_ram_reserve_memblock'
make[2]: *** [arch/arm/plat-omap/common.o] Error 1
make[1]: *** [arch/arm/plat-omap] Error 2

Kevin
