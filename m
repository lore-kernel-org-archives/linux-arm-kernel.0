From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:46:29 +0800
Subject: [PATCH 3/5] ARM: prima2: common: fix checkpatch issues
In-Reply-To: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
References: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1392705991-29967-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

fix the below checkpatch issues:
ERROR: Use of const init definition must use __initconst
30: FILE: common.c:30:
+static const char *atlas6_dt_match[] __initdata = {

ERROR: Use of const init definition must use __initconst
45: FILE: common.c:45:
+static const char *prima2_dt_match[] __initdata = {

ERROR: Use of const init definition must use __initconst
61: FILE: common.c:61:
+static const char *marco_dt_match[] __initdata = {

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index d49aff7..6926dbc 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -27,7 +27,7 @@ static __init void sirfsoc_map_io(void)
 }
 
 #ifdef CONFIG_ARCH_ATLAS6
-static const char *atlas6_dt_match[] __initdata = {
+static const char *atlas6_dt_match[] __initconst = {
 	"sirf,atlas6",
 	NULL
 };
@@ -42,7 +42,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_PRIMA2
-static const char *prima2_dt_match[] __initdata = {
+static const char *prima2_dt_match[] __initconst = {
 	"sirf,prima2",
 	NULL
 };
@@ -58,7 +58,7 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_MARCO
-static const char *marco_dt_match[] __initdata = {
+static const char *marco_dt_match[] __initconst = {
 	"sirf,marco",
 	NULL
 };
-- 
1.7.5.4
