From: tklauser@distanz.ch (Tobias Klauser)
Date: Wed,  5 Mar 2014 17:35:09 +0100
Subject: [PATCH 3/4] ARM: vexpress: storage class should be before const
 qualifier
Message-ID: <1394037309-1805-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/mach-vexpress/platsmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 993c9ae..5310d5c 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -42,7 +42,7 @@ static struct map_desc vexpress_dt_cortex_a9_scu_map __initdata = {
 
 static void *vexpress_dt_cortex_a9_scu_base __initdata;
 
-const static char *vexpress_dt_cortex_a9_match[] __initconst = {
+static const char *vexpress_dt_cortex_a9_match[] __initconst = {
 	"arm,cortex-a5-scu",
 	"arm,cortex-a9-scu",
 	NULL
-- 
1.7.9.5
