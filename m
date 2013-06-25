From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Jun 2013 22:24:47 +0200
Subject: [PATCH v2 1/5] ARM: move VFP init to an earlier boot stage
In-Reply-To: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1372191891-24574-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use the NEON unit in the kernel, we should
initialize it a bit earlier in the boot process so NEON users
that like to do a quick benchmark at load time (like the
xor_blocks or RAID-6 code) find the NEON/VFP unit already
enabled.

Replaced late_initcall() with core_initcall().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 5dfbb0b..791993a 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -731,4 +731,4 @@ static int __init vfp_init(void)
 	return 0;
 }
 
-late_initcall(vfp_init);
+core_initcall(vfp_init);
-- 
1.8.1.2
