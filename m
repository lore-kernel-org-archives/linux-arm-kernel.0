From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 19 Feb 2010 12:27:29 -0700
Subject: [PATCH 3/7] arm-dt: add devictree node reference to dev_archdata
In-Reply-To: <20100219185953.15318.4850.stgit@angua>
References: <20100219185953.15318.4850.stgit@angua>
Message-ID: <20100219192721.15318.13246.stgit@angua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jeremy.kerr@canonical.com>

We'll need to parse device info from the device tree, so add the OF node
to dev->archdata.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/arm/include/asm/device.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..167b156 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -10,6 +10,9 @@ struct dev_archdata {
 #ifdef CONFIG_DMABOUNCE
 	struct dmabounce_device_info *dmabounce;
 #endif
+#ifdef CONFIG_OF
+	struct device_node *of_node;
+#endif
 };
 
 struct pdev_archdata {
