From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 1 Mar 2012 14:28:36 +0100
Subject: [PATCH 1/4] x86: add NO_IRQ macro
In-Reply-To: <cover.1330607068.git.rubini@gnudd.com>
References: <cover.1330607068.git.rubini@gnudd.com>
Message-ID: <6bda7538144dce0bf5780df3d0601147dae753b5.1330607068.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to compile AMBA drivers. Most architectures define
NO_IRQ as -1, and this does the same for the PC.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@linux.intel.com>
---
 arch/x86/include/asm/irq.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index ba870bb..c9072f5 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -10,6 +10,8 @@
 #include <asm/apicdef.h>
 #include <asm/irq_vectors.h>
 
+#define NO_IRQ	(-1)
+
 static inline int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
-- 
1.7.7.2
