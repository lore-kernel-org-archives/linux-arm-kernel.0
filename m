From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Nov 2009 11:20:02 -0800
Subject: [PATCH 01/10] omap: mailbox: Add build specific changes to support
	omap mailbox
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Message-ID: <20091118192002.31148.82970.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: C A Subramaniam <subramaniam.ca@ti.com>

This patch adds changes to the build related files of mailbox
driver

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5c32b65..b77fe24 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -44,6 +44,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
+mailbox_mach-objs			:= mailbox.o
+
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
