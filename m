From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:30:10 +0000
Subject: [PATCH 6/8] ARM: add machine name to stack dump output
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSw6-0002EZ-Kc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic dump_stack() code provides the facility to include the
machine name in the stack dump, which can be useful information.  Add
a call to dump_stack_set_arch_desc() for the generic code to print
this information.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c03106378b49..8361652b6dab 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -900,6 +900,7 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	dump_stack_set_arch_desc("%s", mdesc->name);
 
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;
-- 
1.8.3.1
