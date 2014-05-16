From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 16 May 2014 14:10:15 +0200
Subject: [PATCH 4/5] ARM: shmobile: Let Genmai multiplatform boot with Genmai
 DTB
In-Reply-To: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
References: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400242216-20848-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Let the multiplatform Genmai support boot with the unified DTS.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/Makefile                      | 2 +-
 arch/arm/mach-shmobile/board-genmai-reference.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a6eed6d661ac..3594914bed5d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -312,7 +312,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
-	r7s72100-genmai-reference.dtb \
+	r7s72100-genmai.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 968bbba20d08..2ff6ad6e608e 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -42,7 +42,7 @@ static void __init genmai_add_standard_devices(void)
 }
 
 static const char * const genmai_boards_compat_dt[] __initconst = {
-	"renesas,genmai-reference",
+	"renesas,genmai",
 	NULL,
 };
 
-- 
1.9.2
