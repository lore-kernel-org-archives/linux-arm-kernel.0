From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Fri, 2 Nov 2012 18:02:34 +0530
Subject: [PATCH 03/15] ARM: OMAP: mailbox: Convert to device_initcall
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1351859566-24818-4-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power management code for AM33XX is a late_initcall
and the PM features depend on the mailbox for IPC.
In preparation for this, convert the mailbox init to
a device_initcall.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 7a343aa..8c63c86 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -469,7 +469,7 @@ static void __exit omap2_mbox_exit(void)
 	platform_driver_unregister(&omap2_mbox_driver);
 }
 
-module_init(omap2_mbox_init);
+device_initcall(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
