From: eric.auger@linaro.org (Eric Auger)
Date: Tue,  1 Mar 2016 18:27:48 +0000
Subject: [RFC v5 08/17] msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
In-Reply-To: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1456856877-4817-9-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
Translation Service. On Intel HW this IRQ remapping capability is
abstracted on IOMMU side while on ARM it is abstracted on MSI controller
side. This flag will be used to know whether the MSI passthrough is
safe.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v4 -> v5:
- seperate flag introduction from first user addition (ITS)
---
 include/linux/msi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index a2a0068..03eda72 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -261,6 +261,8 @@ enum {
 	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
 	/* Support PCI MSIX interrupts */
 	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	/* Support MSI IRQ remapping service */
+	MSI_FLAG_IRQ_REMAPPING		= (1 << 5),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
-- 
1.9.1
