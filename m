From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 16 Oct 2017 12:08:23 +0200
Subject: [PATCH 1/2] ARM: davinci: make the function argument as const
In-Reply-To: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
References: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1508148504-2771-2-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the function argument of the function davinci_common_init
as const as it's memory contents are only copied during a
memcpy call. So, the fields of the structure to which the argument
soc_info points to never gets modified and therefore the argument can
be made const.
Add const to the prototype too.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-davinci/common.c              | 2 +-
 arch/arm/mach-davinci/include/mach/common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 9f9fbfa..bcb6a7b 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -77,7 +77,7 @@ static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 	return -EINVAL;
 }
 
-void __init davinci_common_init(struct davinci_soc_info *soc_info)
+void __init davinci_common_init(const struct davinci_soc_info *soc_info)
 {
 	int ret;
 
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 037aa66..433a008 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -79,7 +79,7 @@ struct davinci_soc_info {
 
 extern struct davinci_soc_info davinci_soc_info;
 
-extern void davinci_common_init(struct davinci_soc_info *soc_info);
+extern void davinci_common_init(const struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 void davinci_restart(enum reboot_mode mode, const char *cmd);
 void davinci_init_late(void);
-- 
1.9.1
