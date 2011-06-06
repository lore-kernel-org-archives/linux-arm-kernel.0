From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 06 Jun 2011 01:40:38 -0600
Subject: [PATCH] arm/mxs: Fix build failure on ocotp.c
Message-ID: <20110606074024.23861.55150.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mxs/ocotp.c needs to include asm/processor.h to get the
definition of cpu_relax().

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-mxs/ocotp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
index 65157a3..c7a4d34 100644
--- a/arch/arm/mach-mxs/ocotp.c
+++ b/arch/arm/mach-mxs/ocotp.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 
+#include <asm/processor.h>
+
 #include <mach/mxs.h>
 
 #define OCOTP_WORD_OFFSET		0x20
