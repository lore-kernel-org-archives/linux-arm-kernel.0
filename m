From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Oct 2014 17:18:42 +0100
Subject: [PATCH v2 09/10] arm64: dmi: set DMI string as dump stack arch
 description
In-Reply-To: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1414513123-20400-10-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets the DMI string, containing system type, serial number,
firmware version etc. as dump stack arch description, so that oopses
and other kernel stack dumps automatically have this information
included, if available.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 9ae5e7918b8f..6fac253bc783 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -479,6 +479,8 @@ static int __init arm64_dmi_init(void)
 	 * itself, depends on dmi_scan_machine() having been called already.
 	 */
 	dmi_scan_machine();
+	if (dmi_available)
+		dmi_set_dump_stack_arch_desc();
 	return 0;
 }
 core_initcall(arm64_dmi_init);
-- 
1.8.3.2
