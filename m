From: zlim@broadcom.com (Zi Shen Lim)
Date: Mon, 12 Jan 2015 18:15:03 -0800
Subject: [PATCH boot-wrapper-aarch64 3/4] psci: use PSCI v0.2 function IDs
In-Reply-To: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
Message-ID: <1421115304-19580-4-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update PSCI function IDs to match those defined in
v0.2 of the specification.

Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
---
 Makefile.am | 4 ++--
 psci.S      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0c174e6..4f5bfdd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -25,8 +25,8 @@ BOOTMETHOD	:= psci.o
 PSCI_NODE	:= psci {				\
 			compatible = \"arm,psci\";	\
 			method = \"smc\";		\
-			cpu_on = <0x84000002>;		\
-			cpu_off = <0x84000001>;		\
+			cpu_on = <0xc4000003>;		\
+			cpu_off = <0x84000002>;		\
 		   };
 CPU_NODES	:= $(shell $(top_srcdir)/gen-cpu-nodes.sh $(CPU_IDS))
 CPUS_NODE	:= cpus {		\
diff --git a/psci.S b/psci.S
index d045e56..c51e125 100644
--- a/psci.S
+++ b/psci.S
@@ -8,8 +8,8 @@
  */
 #include "common.S"
 
-#define PSCI_CPU_OFF		0x84000001
-#define PSCI_CPU_ON		0x84000002
+#define PSCI_CPU_OFF		0x84000002
+#define PSCI_CPU_ON		0xc4000003
 
 #define PSCI_RET_SUCCESS	0
 #define PSCI_RET_NOT_IMPL	(-1)
-- 
2.1.0
