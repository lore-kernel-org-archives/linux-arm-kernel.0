From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 12:19:50 +0000
Subject: [PATCH 1/7] arm64: docs: widen silicon-errata kconfig column
In-Reply-To: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1485865196-12742-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that kconfigs for errata we need to handle might end up
being too wide to fit in arm64's existing errata table. We may need to
take errata workarounds (and their associated documentation) via
different trees, and widening the table as required is likely to result
in messy merge conflicts.

We can minimise this messiness by widening the column in a separate
patch as a preparatory step. Thus, only the additional lines should
conflict, which is simple to address.

This patch widens the kconfig column by 10 characters, which is
sufficient to fit upcoming errata workarounds. A whitespace mixup is
also corrected, such that all columns are consistently padded using
tabs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 405da11..4a5e6cc 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -42,24 +42,24 @@ file acts as a registry of software workarounds in the Linux Kernel and
 will be updated when new workarounds are committed and backported to
 stable kernels.
 
-| Implementor    | Component       | Erratum ID      | Kconfig                 |
-+----------------+-----------------+-----------------+-------------------------+
-| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319    |
-| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319    |
-| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069    |
-| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472    |
-| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719    |
-| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419    |
-| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
-| ARM            | Cortex-A57      | #852523         | N/A                     |
-| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
-| ARM            | Cortex-A72      | #853709         | N/A                     |
-| ARM            | MMU-500         | #841119,#826419 | N/A                     |
-|                |                 |                 |                         |
-| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
-| Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144    |
-| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
-| Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
-| Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
-|                |                 |                 |                         |
-| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
+| Implementor    | Component       | Erratum ID      | Kconfig                          |
++----------------+-----------------+-----------------+----------------------------------+
+| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319             |
+| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319             |
+| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069             |
+| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472             |
+| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719             |
+| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419             |
+| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075             |
+| ARM            | Cortex-A57      | #852523         | N/A                              |
+| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220             |
+| ARM            | Cortex-A72      | #853709         | N/A                              |
+| ARM            | MMU-500         | #841119,#826419 | N/A                              |
+|                |                 |                 |                                  |
+| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375             |
+| Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144             |
+| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154             |
+| Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456             |
+| Cavium         | ThunderX SMMUv2 | #27704          | N/A                              |
+|                |                 |                 |                                  |
+| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585              |
-- 
1.9.1
