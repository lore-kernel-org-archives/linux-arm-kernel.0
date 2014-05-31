From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Sat, 31 May 2014 01:36:40 +0100
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We would like to be able to describe PCIe ECAM resources as
IORESOURCE_MEM blocks while distinguish them from standard
memory resources. Add an IORESOURCE_BIT entry for this case.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 include/linux/ioport.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5e3a906..9672533 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -103,6 +103,7 @@ struct resource {
 
 /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
 #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
+#define IORESOURCE_PCI_ECFG		(1<<5)  /* ECAM config resource */
 
 
 /* helpers to define resources */
-- 
1.9.2
