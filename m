From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Mar 2012 10:29:54 -0700
Subject: [PATCH 3/9] ARM: omap2/n8x0: work around modular omap mmc
In-Reply-To: <1332522836-29517-4-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20120323172953.GD9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* mathieu.poirier at linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: Russell King <linux@arm.linux.org.uk>
> 
> When the omap driver is built as a module for n8x0,
> n8x0_mmc_set_power_menelaus cannot call into the driver:
> 
> arch/arm/mach-omap2/board-n8x0.c:374: undefined reference
> to `omap_mmc_notify_cover_event'
> 
> As a workaround, do not provide that device in this case. This needs
> to be fixed properly, e.g. by converting n8x0 to be probed through the
> device tree and moving that code into the driver.

This too should be fixed now in a way where just the cover events
won't work if compiled as a module.

Regards,

Tony
