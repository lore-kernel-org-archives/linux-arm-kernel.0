From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Feb 2013 13:51:39 -0800
Subject: [PATCH] arm/omap2: Fix build failures
In-Reply-To: <1362077583-11184-1-git-send-email-linux@roeck-us.net>
References: <1362077583-11184-1-git-send-email-linux@roeck-us.net>
Message-ID: <20130228215138.GJ1622@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Guenter Roeck <linux@roeck-us.net> [130228 11:21]:
> Commit c1d1cd59 (omap_device: remove obsolete pm_lats and early_device code)
> changed the number of parameters to omap_device_build(), but did not fix all
> calling code correctly. This causes build failures with some configurations.
> 
> arch/arm/mach-omap2/devices.c: In function 'omap_init_hdmi_audio':
> arch/arm/mach-omap2/devices.c:429:2: error: too many arguments to function 'omap_device_build'
> arch/arm/mach-omap2/omap_device.h:74:25: note: declared here
> make[2]: [arch/arm/mach-omap2/devices.o] Error 1 (ignored)
> arch/arm/mach-omap2/sr_device.c: In function 'sr_dev_init':
> arch/arm/mach-omap2/sr_device.c:155:2: error: too many arguments to function 'omap_device_build'
> arch/arm/mach-omap2/omap_device.h:74:25: note: declared here
> make[2]: [arch/arm/mach-omap2/sr_device.o] Error 1 (ignored)
> arch/arm/mach-omap2/am35xx-emac.c: In function 'omap_davinci_emac_dev_init':
> arch/arm/mach-omap2/am35xx-emac.c:66:6: error: too many arguments to function 'omap_device_build'
> arch/arm/mach-omap2/omap_device.h:74:25: note: declared here

Thanks, we already have a fix for this in linux next as
commit 6efc3fe0 (ARM: OMAP2+: fix some omap_device_build() calls that
aren't compiled by default). It seems that it will get sent today as
part of the rest of the arm-soc late branches.

Regards,

Tony
