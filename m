From: jason77.wang@gmail.com (Jason Wang)
Date: Tue,  1 Jun 2010 23:10:42 +0800
Subject: [PATCH 2/3] mxc/iomux: add GPIO bank offset for iomux v3 platforms
In-Reply-To: <1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <1275405043-18230-3-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These GPIO bank offsets are useful when define a gpio number.
E.G. when GPIO PORTC pin 6 is used for irq request pin of external
expanding device, we can define it like:
  #define EXP_PARENT_IRQ_PIN (GPIO_PORTC + 6)

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/plat-mxc/include/mach/iomux-v3.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index f2f73d3..0880a4a 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -89,6 +89,21 @@ struct pad_desc {
 #define PAD_CTL_SRE_FAST		(1 << 0)
 #define PAD_CTL_SRE_SLOW		(0 << 0)
 
+
+#define MX51_NUM_GPIO_PORT	4
+
+#define GPIO_PIN_MASK 0x1f
+
+#define GPIO_PORT_SHIFT 5
+#define GPIO_PORT_MASK (0x7 << GPIO_PORT_SHIFT)
+
+#define GPIO_PORTA	(0 << GPIO_PORT_SHIFT)
+#define GPIO_PORTB	(1 << GPIO_PORT_SHIFT)
+#define GPIO_PORTC	(2 << GPIO_PORT_SHIFT)
+#define GPIO_PORTD	(3 << GPIO_PORT_SHIFT)
+#define GPIO_PORTE	(4 << GPIO_PORT_SHIFT)
+#define GPIO_PORTF	(5 << GPIO_PORT_SHIFT)
+
 /*
  * setups a single pad in the iomuxer
  */
-- 
1.5.6.5
