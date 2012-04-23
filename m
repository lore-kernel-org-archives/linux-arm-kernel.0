From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 23 Apr 2012 13:22:07 -0600 (MDT)
Subject: [PATCH v2 1/3] ARM: OMAP2+: omap_hwmod: Add interface to
 incorporate module level wakeup
In-Reply-To: <1334920207-19160-2-git-send-email-govindraj.raja@ti.com>
References: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
 <1334920207-19160-2-git-send-email-govindraj.raja@ti.com>
Message-ID: <alpine.DEB.2.00.1204231318110.15883@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 20 Apr 2012, Govindraj.R wrote:

> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
> PM_WKEN1_CORE/PM_WKEN_PER regs. The module level wakeups are enabled by
> default, by PRM soft reset default value of PM_WKEN reg is all one's which means
> all module level wakeups are enabled.
> 
> However the wakeups can be enabled/disabled using sysfs entry example for uart:
> echo disabled > /sys/devices/platform/omap/omap_uart.X/power/wakeup
> [X=0,1,2,3]
> 
> So expand omap2 prcm structure to incorporate the PM_WKEN reg offset
> and bit mask to control the module level wakeup. This info from hwmod
> data can be used from hwmod framework in omap_hwmod_enable/disable_wakeup
> api's to configure module level wakeups.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

This patch is not needed.  The data contained in your .module_wakeup_offs 
field can be calculated from the existing struct omap_hwmod.prcm.omap2 
fields, specifically .prcm_reg_id and .module_offs.  And the 
module_wakeup_bit shift should be identical to the .module_bit, so there 
should be no need for a separate field for that either.


- Paul
