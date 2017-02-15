From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 15 Feb 2017 16:54:07 -0500
Subject: [PATCH] Documentation: Note QDF2400 SoC Erratum 44
Message-ID: <20170215215407.25854-1-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
and 2400v1 SoCs.Checking that the Transmit FIFO Empty (TXFE) bit is 0,
instead of checking that the BUSY bit is 1, works around the issue. Note
this in the customary location. To minimize conflicts, this documentation
update is separate from the code changes, "tty: pl011: Work around QDF2400
E44 stuck BUSY bit".

Signed-off-by: Christopher Covington <cov@codeaurora.org>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Timur Tabi <timur@codeaurora.org>
---
Documentation to go with https://patchwork.kernel.org/patch/9575103/
Based on http://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
---
 Documentation/arm64/silicon-errata.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index a71b8095dbd8..bc3d086bc624 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -68,3 +68,5 @@ stable kernels.
 |                |                 |                 |                             |
 | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
+| Qualcomm Tech. | QDF2432v1 UART  | SoC E44         | N/A                         |
+| Qualcomm Tech. | QDF2400v1 UART  | SoC E44         | N/A                         |
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.
