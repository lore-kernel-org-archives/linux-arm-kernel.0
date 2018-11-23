From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Nov 2018 18:41:07 +0000
Subject: [PATCH v2 8/8] arm64: Add configuration/documentation for Cortex-A76
 erratum 1165522
In-Reply-To: <20181123184107.39334-1-marc.zyngier@arm.com>
References: <20181123184107.39334-1-marc.zyngier@arm.com>
Message-ID: <20181123184107.39334-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the infrastructure to handle erratum 1165522 is in place,
let's make it a selectable option and add the required documentation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 76ccded8b74c..04f0bc4690c6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -57,6 +57,7 @@ stable kernels.
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188873       |
+| ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..a68bc6cc2167 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -497,6 +497,18 @@ config ARM64_ERRATUM_1188873
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1165522
+	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
+	default y
+	help
+	  This option adds work arounds for ARM Cortex-A76 erratum 1165522
+
+	  Affected Cortex-A76 cores (r0p0, r1p0, r2p0) could end-up with
+	  corrupted TLBs by speculating an AT instruction during a guest
+	  context switch.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
-- 
2.19.1
