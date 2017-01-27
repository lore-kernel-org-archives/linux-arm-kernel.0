From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 27 Jan 2017 12:22:54 +0000
Subject: [PATCH] iommu: Better document the IOMMU_PRIV flag
In-Reply-To: <1483709296-32761-2-git-send-email-sricharan@codeaurora.org>
References: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
 <1483709296-32761-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <edc67cc1775f3bafb6895346184e8042fd881ba4.1485519627.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a fairly subtle thing - let's make sure it's described as
clearly as possible to avoid potential misunderstandings.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Having another look through the IOMMU_PRIV series, I wasn't convinced
that the original comment was really all that helpful - I'm happy for
this to be squashed in if you like.

Robin.

 include/linux/iommu.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 69e2417a2965..3c830e153069 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -32,10 +32,13 @@
 #define IOMMU_NOEXEC	(1 << 3)
 #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
 /*
- * This is to make the IOMMU API setup privileged
- * mapppings accessible by the master only at higher
- * privileged execution level and inaccessible at
- * less privileged levels.
+ * Where the bus hardware includes a privilege level as part of its access type
+ * markings, and certain devices are capable of issuing transactions marked as
+ * either 'supervisor' or 'user', the IOMMU_PRIV flag requests that the other
+ * given permission flags only apply to accesses@the higher privilege level,
+ * and that unprivileged transactions should have as little access as possible.
+ * This would usually imply the same permissions as kernel mappings on the CPU,
+ * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
 
-- 
2.11.0.dirty
