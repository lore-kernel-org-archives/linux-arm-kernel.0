From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 23 Jan 2012 13:26:47 +0530
Subject: [PATCH] ARM: OMAP: id: Add missing break statement in
 omap3xxx_check_revision
Message-ID: <1327305407-19914-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing break statement in the function omap3xxx_check_revision.

The commit id 4390f5b2cb1f56 [ARM: OMAP: TI814X: Add cpu type macros
and detection support], removed the 'break' statement from the function
omap3xxx_check_revision(), resulting into wrong omap/cpu_revision
initialization for AM335x devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 325e12e..32cf203 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -395,6 +395,7 @@ void __init omap3xxx_check_revision(void)
 	case 0xb944:
 		omap_revision = AM335X_REV_ES1_0;
 		cpu_rev = "1.0";
+		break;
 	case 0xb8f2:
 		switch (rev) {
 		case 0:
--
1.7.0.4
