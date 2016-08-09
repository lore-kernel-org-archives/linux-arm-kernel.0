From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  9 Aug 2016 11:03:56 +0100
Subject: [PATCH RESEND] MAINTAINERS: add ARM ARCHITECTED TIMER entry
Message-ID: <1470737036-2082-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architected timer driver falls under the drivers/clocksource/
catch-all in MAINTAINERS, and get_maintainers.pl doesn't suggest a
number of people who should be Cc'd.

The ARM architected timer is a core component of ARMv7+VE and ARMv8, and
is critical to the correct operation of both architecture ports (and
their respective KVM code), and patches to it should have review by
knowledgeable interested parties.

This patch adds a MAINTAINERS entry for the driver and its low-level
arch components, such that get_maintainer.pl will always include
relevant interested parties for modifications to the driver. For the
timebeing, this means myself and Marc Zyngier.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

Apologies for the resend; I typo'd vger.kernel.org.

Mark.

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..85450ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -881,6 +881,15 @@ S:	Supported
 F:	drivers/gpu/drm/arc/
 F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
 
+ARM ARCHITECTED TIMER DRIVER
+M:	Mark Rutland <mark.rutland@arm.com>
+M:	Marc Zyngier <marc.zyngier@arm.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/include/asm/arch_timer.h
+F:	arch/arm64/include/asm/arch_timer.h
+F:	drivers/clocksource/arm_arch_timer.c
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-- 
1.9.1
