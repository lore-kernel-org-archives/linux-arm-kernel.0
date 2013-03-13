From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Mar 2013 18:31:59 -0700
Subject: [PATCH 1/3] ARM: Clear IDIVT hwcap if CONFIG_ARM_THUMB=n
In-Reply-To: <1363138321-27849-1-git-send-email-sboyd@codeaurora.org>
References: <1363138321-27849-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1363138321-27849-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't advertise support for the SDIV/UDIV thumb instructions if
the kernel is not compiled with support for thumb userspace. This
is in line with how we remove the THUMB hwcap in these
configurations.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..e2c8bbf 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -484,7 +484,7 @@ static void __init setup_processor(void)
 		 list->elf_name, ENDIANNESS);
 	elf_hwcap = list->elf_hwcap;
 #ifndef CONFIG_ARM_THUMB
-	elf_hwcap &= ~HWCAP_THUMB;
+	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
 #endif
 
 	feat_v6_fixup();
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
