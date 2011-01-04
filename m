From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Tue,  4 Jan 2011 11:37:06 +0530
Subject: [PATCH] Trivial: ARM: pxa168: Bug fix - correct UART DMA channels
Message-ID: <1294121226-3358-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to ARMADA_16x_Software_Manual.pdf, DMA channels for
UART1 are 19, 20 and DMA channels for UART2 are 21, 22.

It's of little significance for now as the PXA UART driver
doesn't use DMA as of now.

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/pxa168.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..7564739 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -147,8 +147,8 @@ void pxa168_clear_keypad_wakeup(void)
 }
 
 /* on-chip devices */
-PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 21, 22);
-PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 23, 24);
+PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 19, 20);
+PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 21, 22);
 PXA168_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
 PXA168_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
 PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000, 0x10);
-- 
1.7.0.4
