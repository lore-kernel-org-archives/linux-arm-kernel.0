From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  9 Dec 2012 09:21:07 +0400
Subject: [PATCH] ARM: Pass real "__machine_arch_type" variable to
 setup_machine_tags() procedure
In-Reply-To: <20121208121444.GE14363@n2100.arm.linux.org.uk>
References: <20121208121444.GE14363@n2100.arm.linux.org.uk>
Message-ID: <1355030467-25863-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This modification is needed to proper boot the custom machines with
the IDs that are not described in the mach-types.h table.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 86d1429..95fcaa0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -744,7 +744,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
-		mdesc = setup_machine_tags(__atags_pointer, machine_arch_type);
+		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
 
-- 
1.7.8.6
