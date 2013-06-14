From: joe@perches.com (Joe Perches)
Date: Thu, 13 Jun 2013 19:37:26 -0700
Subject: [Trivial PATCH 01/33] arm: kernel: isa: Convert use of typedef
 ctl_table to struct ctl_table
In-Reply-To: <cover.1371177118.git.joe@perches.com>
References: <cover.1371177118.git.joe@perches.com>
Message-ID: <e78cf3653228ef35505d50e94c29e71650903a17.1371177118.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This typedef is unnecessary and should just be removed.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/kernel/isa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index 3464859..9d1cf71 100644
--- a/arch/arm/kernel/isa.c
+++ b/arch/arm/kernel/isa.c
@@ -20,7 +20,7 @@
 
 static unsigned int isa_membase, isa_portbase, isa_portshift;
 
-static ctl_table ctl_isa_vars[4] = {
+static struct ctl_table ctl_isa_vars[4] = {
 	{
 		.procname	= "membase",
 		.data		= &isa_membase, 
@@ -44,7 +44,7 @@ static ctl_table ctl_isa_vars[4] = {
 
 static struct ctl_table_header *isa_sysctl_header;
 
-static ctl_table ctl_isa[2] = {
+static struct ctl_table ctl_isa[2] = {
 	{
 		.procname	= "isa",
 		.mode		= 0555,
@@ -52,7 +52,7 @@ static ctl_table ctl_isa[2] = {
 	}, {}
 };
 
-static ctl_table ctl_bus[2] = {
+static struct ctl_table ctl_bus[2] = {
 	{
 		.procname	= "bus",
 		.mode		= 0555,
-- 
1.8.1.2.459.gbcd45b4.dirty
