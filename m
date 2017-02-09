From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Feb 2017 17:00:34 +0000
Subject: [PATCH] arm64: arch_timer: document Hisilicon erratum 161010101
Message-ID: <1486659634-24376-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>

Now that we have a workaround for Hisilicon erratum 161010101, notes
this in the arm64 silicon-errata document.

The new config option is too long to fit in the existing kconfig column,
so this is widened to accomodate it. At the same time, an existing
whitespace error is corrected, and the existing pattern of a line space
between vendors is enforced for recent additions.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
[Mark: split patch, reword commit message, rework table]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/silicon-errata.txt | 47 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 22 deletions(-)

Hi Will,

As discussed [1], I'm sending this now that Daniel's pull [2] with the
corresponding patches has been taken into tip's timers/core branch [3].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/484707.html
[2] https://lkml.kernel.org/r/20170208231208.GB12695 at mai
[3] https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=timers/core

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 0006a94..dd7c792 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -42,25 +42,28 @@ file acts as a registry of software workarounds in the Linux Kernel and
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
-| Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009|
+| Implementor    | Component       | Erratum ID      | Kconfig                     |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
+| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
+| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069        |
+| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472        |
+| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719        |
+| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419        |
+| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075        |
+| ARM            | Cortex-A57      | #852523         | N/A                         |
+| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
+| ARM            | Cortex-A72      | #853709         | N/A                         |
+| ARM            | MMU-500         | #841119,#826419 | N/A                         |
+|                |                 |                 |                             |
+| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
+| Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144        |
+| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
+| Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
+| Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
+|                |                 |                 |                             |
+| Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
+|                |                 |                 |                             |
+| Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
+|                |                 |                 |                             |
+| Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
-- 
1.9.1
