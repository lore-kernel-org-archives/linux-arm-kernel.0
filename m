From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Tue, 5 Mar 2013 11:34:09 +0530
Subject: [PATCH] ARM:SPEAr3xx: fix compilation breakage due to missing header
 file
Message-ID: <7dd824ea0e7427a203c459fc4084d304ace44c9e.1362461902.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 3a95b9fb (pl080.h: moved from arm/include/asm/hardware to
include/linux/amba/) broke the compilation for SPEAr3xx machine.

This patch is to include missing header file in spear3xx.c.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/mach-spear3xx/spear3xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index f9d754f..7c218d9 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "SPEAr3xx: " fmt
 
 #include <linux/amba/pl022.h>
+#include <linux/amba/pl080.h>
 #include <linux/amba/pl08x.h>
 #include <linux/io.h>
 #include <plat/pl080.h>
-- 
1.7.3.4
