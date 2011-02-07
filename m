From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon,  7 Feb 2011 02:51:59 +0100
Subject: [PATCH 07/09] ARM: s3c2440: gta02: Call regulator_has_full_constraints
In-Reply-To: <1297043521-21903-1-git-send-email-lars@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
Message-ID: <1297043521-21903-7-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the end of gta02_pmu_attach_child_devices all drivers should have taken
control of their regulators and we can tell the regulator core to disable all
regulators which are currently not in use.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 01e0930..1396639 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -563,6 +563,8 @@ static void gta02_pmu_attach_child_devices(struct pcf50633 *pcf)
 
 	platform_add_devices(gta02_devices_pmu_children,
 			     ARRAY_SIZE(gta02_devices_pmu_children));
+
+	regulator_has_full_constraints();
 }
 
 static void gta02_poweroff(void)
-- 
1.7.2.3
