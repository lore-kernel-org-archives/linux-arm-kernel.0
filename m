From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Nov 2012 11:08:35 +0100
Subject: OMAP* Latest build failures
In-Reply-To: <20121114092643.GG3290@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Message-ID: <50A36DA3.2080201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 11/14/2012 10:26 AM, Russell King - ARM Linux wrote:
> OMAP* allnoconfig fails:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
> twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
> arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
> twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
> arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
> twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
> twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
> twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
> arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
> twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
> arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
> twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'

Not sure what is going on here but neither of these are referenced within
twl-common.c directly.

> OMAP4 randconfig fails:
> 
> arch/arm/mach-omap2/cm_common.c: In function 'cm_register':
> arch/arm/mach-omap2/cm_common.c:42:11: error: 'EINVAL' undeclared (first use in this function)
> arch/arm/mach-omap2/cm_common.c:45:11: error: 'EEXIST' undeclared (first use in this function)
> arch/arm/mach-omap2/cm_common.c: In function 'cm_unregister':
> arch/arm/mach-omap2/cm_common.c:66:11: error: 'EINVAL' undeclared (first use in this function)

I have already sent a patch to fix this:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/131341.html

> You know where to find the build information and results...

It seams I can not find the link in my mail archives. Could you point me to
the correct place?

-- 
P?ter
