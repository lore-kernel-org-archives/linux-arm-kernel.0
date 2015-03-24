From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 24 Mar 2015 17:58:53 +0000
Subject: [PATCH 3/5] ARM64: kernel: psci: let ACPI probe PSCI version
In-Reply-To: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1427219940-27201-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCI v0.2+ allows the kernel to probe the PSCI firmware version.

This patch replaces the default initialization of PSCI v0.2+
functions with code that allows probing PSCI firmware version
and initializes PSCI functions accordingly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/psci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 2caac44..ea18cb5 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -439,9 +439,7 @@ int __init psci_acpi_init(void)
 	else
 		invoke_psci_fn = __invoke_psci_fn_smc;
 
-	psci_0_2_set_functions();
-
-	return 0;
+	return psci_probe();
 }
 
 #ifdef CONFIG_SMP
-- 
2.2.1
