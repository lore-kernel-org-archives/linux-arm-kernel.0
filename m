From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 Nov 2012 13:45:15 +0200
Subject: OMAP* Latest build failures
In-Reply-To: <20121114092643.GG3290@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Message-ID: <50A3844B.8040208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-14 11:26, Russell King - ARM Linux wrote:
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

I'm not able to reproduce this. I took v3.7-rc5, and the omap4430-sdp
noconfig
(http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2711),
and it builds fine for me.

>From the error log
(http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2711)
I see that arch/arm/plat-omap/omap-pm-noop.c is not compiled, which is
where the above functions are. However, the config contains
CONFIG_OMAP_PM_NOOP=y, which should cause omap-pm-noop.c to be compiled.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/caa91e54/attachment.sig>
