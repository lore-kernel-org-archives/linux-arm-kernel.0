From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu,  1 Aug 2013 13:13:41 +0100
Subject: [PATCH 2/2] ARM: STi: remove sti_secondary_start from INIT section.
In-Reply-To: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
References: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1375359221-21848-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes sti_secondary_start from _INIT section, there are 2
reason for this removal.
 1. discarding such a small code does not save much, given the RAM
sizes.
 2. Having this code discarded, creates corruption issue when we boot
smp-kernel with nrcpus=1 or with single cpu node in DT.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-sti/headsmp.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
index 78ebc75..4c09bae 100644
--- a/arch/arm/mach-sti/headsmp.S
+++ b/arch/arm/mach-sti/headsmp.S
@@ -16,8 +16,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
-
 /*
  * ST specific entry point for secondary CPUs.  This provides
  * a "holding pen" into which all secondary cores are held until we're
-- 
1.7.6.5
