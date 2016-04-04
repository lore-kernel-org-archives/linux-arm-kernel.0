From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  4 Apr 2016 08:19:29 +0000
Subject: [PATCH v6 1/4] msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
In-Reply-To: <1459757972-2814-1-git-send-email-eric.auger@linaro.org>
References: <1459757972-2814-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1459757972-2814-2-git-send-email-eric.auger@linaro.org>
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
index 8b425c6..08441b1 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -270,6 +270,8 @@ enum {
 	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
 	/* Support PCI MSIX interrupts */
 	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	/* Support MSI IRQ remapping service */
+	MSI_FLAG_IRQ_REMAPPING		= (1 << 5),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
-- 
1.9.1
