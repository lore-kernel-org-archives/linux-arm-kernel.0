From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Tue, 24 Feb 2015 01:20:21 +0100
Subject: [PATCH v3 linux-next] iommu: Enable LPAE pagetable on ARM and ARM64
 only
In-Reply-To: <3203874.zEMjzr0PS0@avalon>
References: <3203874.zEMjzr0PS0@avalon>
Message-ID: <1424737221-1193-1-git-send-email-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LPAE iommu page table makes sense only for ARM and ARM64 architectures. Add the
corresponding dependency in Kconfig (and enable for COMPILE_TEST, too, as per
Laurent's suggestion).

Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Will Deacon <will.deacon@arm.com>
---


On 02/24/2015 01:02 AM, Laurent Pinchart wrote:
> Shouldn't this be ARM || ARM64 || COMPILE_TEST ?

Hi Laurent,

It makes perfect sense; thanks. I completely forgot, as I have yet to see one
of those. Here is v3 of the patch.

Best regards,

V.


Changes since v2:
- Add condition on ARM64

Changes since v1:
- Add condition on COMPILE_TEST


 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index baa0d97..a440922 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
 
 config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
+	depends on ARM || ARM64 || COMPILE_TEST
 	select IOMMU_IO_PGTABLE
 	help
 	  Enable support for the ARM long descriptor pagetable format.
-- 
2.1.4
