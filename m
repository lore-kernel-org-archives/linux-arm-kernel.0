From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 18 Jul 2012 12:04:41 +0530
Subject: [PATCH v3 04/11] arm: omap: hwmod: add a new addr space in otg for
 writing to control module
In-Reply-To: <1342593288-7872-1-git-send-email-kishon@ti.com>
References: <1342593288-7872-1-git-send-email-kishon@ti.com>
Message-ID: <1342593288-7872-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox register for usb otg in omap is present in control module.
On detection of any events VBUS or ID, this register should be written
to send the notification to musb core.

Till we have a separate control module driver to write to control module,
omap2430 will handle the register writes to control module by itself. So
a new address space to represent this control module register is added
to usb_otg_hs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ba24d15..c50d828 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5922,6 +5922,11 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
 		.pa_end		= 0x4a0ab7ff,
 		.flags		= ADDR_TYPE_RT
 	},
+	{
+		.pa_start	= 0x4a00233c,
+		.pa_end		= 0x4a00233f,
+		.flags		= ADDR_TYPE_RT
+	},
 	{ }
 };
 
-- 
1.7.5.4
