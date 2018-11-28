From: rrichter@cavium.com (Robert Richter)
Date: Wed, 28 Nov 2018 14:43:37 +0000
Subject: [PATCH v2 10/10] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
Message-ID: <20181128144240.28727-11-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ITS is initialized with with the subsys_initcall now, we don't
need to enable ITS children earlier. Due to the use of irq_domain_
request_host_*() there are no order dependencies when initializing irq
domains.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   | 2 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 81dfc534ded8..f6df5ea16aef 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -111,4 +111,4 @@ static int __init its_fsl_mc_msi_init(void)
 	return 0;
 }
 
-early_initcall(its_fsl_mc_msi_init);
+subsys_initcall(its_fsl_mc_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 7d7366d55d34..9c4a0ebdab0b 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -215,4 +215,4 @@ static int __init its_pci_msi_init(void)
 	its_pci_acpi_msi_init();
 	return 0;
 }
-early_initcall(its_pci_msi_init);
+subsys_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 1f2849bc58c4..76f8a2e85375 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -201,4 +201,4 @@ static int __init its_pmsi_init(void)
 	its_pmsi_acpi_init();
 	return 0;
 }
-early_initcall(its_pmsi_init);
+subsys_initcall(its_pmsi_init);
-- 
2.11.0
