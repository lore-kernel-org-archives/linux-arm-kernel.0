From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Jun 2014 11:49:35 +0800
Subject: [PATCH v4 12/13] ARM64 / ACPI: if we chose to boot from acpi then
 disable FDT
In-Reply-To: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1403840976-7456-13-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=off has not been passed. Then do not unflat devicetree
effectively disabling further hardware probing from DT.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 arch/arm64/kernel/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9dedb0b..487fd1f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -394,7 +394,8 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_idmap_init();
 
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.7.9.5
