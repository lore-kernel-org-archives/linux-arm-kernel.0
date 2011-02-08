From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue,  8 Feb 2011 03:55:20 +0100
Subject: [PATCH v2 07/09] ARM: s3c2440: gta02: Call
	regulator_has_full_constraints
In-Reply-To: <1297043521-21903-7-git-send-email-lars@metafoo.de>
References: <1297043521-21903-7-git-send-email-lars@metafoo.de>
Message-ID: <1297133720-18178-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the regulator core to disable all regulators which are not in use
at the end of the kernel init phase.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 01e0930..2682592 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -590,6 +590,8 @@ static void __init gta02_machine_init(void)
 
 	platform_add_devices(gta02_devices, ARRAY_SIZE(gta02_devices));
 	pm_power_off = gta02_poweroff;
+
+	regulator_has_full_constraints();
 }
 
 
-- 
1.7.2.3
