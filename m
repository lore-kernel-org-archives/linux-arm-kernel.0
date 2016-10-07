From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 07 Oct 2016 11:21:06 -0500
Subject: [PATCH 2/5] PCI: aardvark: Reorder accessor functions
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20161007162106.22668.45585.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder the accessors so the reader is first, as most other drivers do.
Uninline them.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index fd0e6af..3d629d4 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -209,14 +209,14 @@ struct advk_pcie {
 	int root_bus_nr;
 };
 
-static inline void advk_writel(struct advk_pcie *advk, u32 val, u64 reg)
+static u32 advk_readl(struct advk_pcie *advk, u64 reg)
 {
-	writel(val, advk->base + reg);
+	return readl(advk->base + reg);
 }
 
-static inline u32 advk_readl(struct advk_pcie *advk, u64 reg)
+static void advk_writel(struct advk_pcie *advk, u32 val, u64 reg)
 {
-	return readl(advk->base + reg);
+	writel(val, advk->base + reg);
 }
 
 static int advk_pcie_link_up(struct advk_pcie *advk)
