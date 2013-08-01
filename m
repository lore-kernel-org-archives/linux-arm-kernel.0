From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu,  1 Aug 2013 13:40:55 +0100
Subject: [RFC] ARM: ux500: remove u8500_secondary_startup from INIT section.
Message-ID: <1375360855-25219-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes u8500_secondary_startup from _INIT section, there are
two  reason for this removal.
1. discarding such a small code does not save much, given the RAM sizes.
2. Having this code discarded, creates corruption issue when we boot
smp-kernel with nr_cpus=1 or with single cpu node in DT.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
Hi,

I did encounter corruption issues on STi CA9 SOCs when a SMP kernel is booted with
nr_cpus=1. This boiled down to freeing the __INIT section of the secondary
startup code. It looks like two other SOCs(Spear and ux500) might have same
issue.

Do you think this patch is valid for ux500?

Thanks,
srini

 arch/arm/mach-ux500/headsmp.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
index 08da5589..9cdea04 100644
--- a/arch/arm/mach-ux500/headsmp.S
+++ b/arch/arm/mach-ux500/headsmp.S
@@ -11,8 +11,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
-
 /*
  * U8500 specific entry point for secondary CPUs.
  */
-- 
1.7.6.5
