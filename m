From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Oct 2014 16:21:53 +0200
Subject: [PATCH 10/10] arm64: dmi: set DMI string as dump stack arch
 description
In-Reply-To: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1413987713-30528-11-git-send-email-ard.biesheuvel@linaro.org>
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
index 0e9da0067ef2..baab9344a32b 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -477,6 +477,8 @@ static int __init arm64_dmi_init(void)
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
