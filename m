From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 19 Dec 2012 06:53:10 +0000
Subject: arch/arm/mach-omap2/i2c.c:130:2: error: implicit declaration of
 function 'omap_pm_set_max_mpu_wakeup_lat'
In-Reply-To: <20121219022247.GA11170@localhost>
References: <20121219021102.GA9472@localhost>
 <20121219022247.GA11170@localhost>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9A322@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 07:52:47, Fengguang Wu wrote:
> [add more CC]
> 
> On Wed, Dec 19, 2012 at 10:11:02AM +0800, Fengguang Wu wrote:
> > Hi Linus, Wolfram,
> > 
> > FYI, kernel build failed on
> > 
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> > head:   752451f01c4567b506bf4343082682dbb8fb30dd
> > commit: 752451f01c4567b506bf4343082682dbb8fb30dd Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux
> > date:   56 minutes ago
> > config: make ARCH=arm omap2plus_defconfig
> > 
> > All error/warnings:
> > 
> > arch/arm/mach-omap2/i2c.c: In function 'omap_pm_set_max_mpu_wakeup_lat_compat':
> > arch/arm/mach-omap2/i2c.c:130:2: error: implicit declaration of function 'omap_pm_set_max_mpu_wakeup_lat' [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> > 
> > The root cause is, i2c.c (which is always compiled in arch/arm/mach-omap2/Makefile)
> > uses omap_pm_set_max_mpu_wakeup_lat() which is defined in omap-pm-noop.c (which
> > is compiled only on CONFIG_OMAP_PM_NOOP).

CONFIG_OMAP_PM_NOOP is defined. The build breakage is due to a missing header inclusion.
I just sent a patch for this [1]

There are still a couple of patches missing before omap2plus_defconfig compiles
https://patchwork.kernel.org/patch/1810481/
https://patchwork.kernel.org/patch/1810441/

I guess they are on the way from some other tree.

Regards,
Vaibhav

[1] http://marc.info/?l=linux-arm-kernel&m=135589966017628&w=2
