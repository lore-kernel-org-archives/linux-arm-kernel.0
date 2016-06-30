From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Jun 2016 22:37:06 -0700
Subject: Extcon build failure in next
Message-ID: <20160630053705.GM28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

Looks like current Linux next fails to build with at least
omap2plus_defconfig because of:

ERROR: "extcon_dev_allocate" [drivers/extcon/devres.ko] undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed
make[1]: *** [__modpost] Error 1
Makefile:1163: recipe for target 'modules' failed
make: *** [modules] Error 2
Kernel build failed

Probably extcon_dev_allocate just needs EXPORT_SYMBOL_GPL?

Regards,

Tony
