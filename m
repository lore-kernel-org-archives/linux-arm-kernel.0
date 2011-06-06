From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:48 +0100
Subject: [PATCH 04/11] ARM: hwcaps: add new HWCAP defines for ARMv7-A
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARMv7-A cores can optionally implement these new hardware
features:

- VFPv4:
    The latest version of the ARMv7 vector floating-point extensions,
    including hardware support for fused multiple accumulate. D16 or D32
    variants may be implemented.

- Integer divide:
    The SDIV and UDIV instructions provide signed and unsigned integer
    division in hardware. When implemented, these instructions may be
    available in either both Thumb and ARM, or Thumb only.

This patch adds new HWCAP defines to describe these new features. The
integer divide capabilities are split into two bits for ARM and Thumb
respectively. Whilst HWCAP_IDIVA should never bet set if HWCAP_IDIVT is
clear, separating the bits makes it easier to interpret from userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hwcap.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
index 81512db..69d69f5 100644
--- a/arch/arm/include/asm/hwcap.h
+++ b/arch/arm/include/asm/hwcap.h
@@ -20,6 +20,11 @@
 #define HWCAP_VFPv3	(1 << 13)
 #define HWCAP_VFPv3D16	(1 << 14)
 #define HWCAP_TLS	(1 << 15)
+#define HWCAP_VFPv4	(1 << 16)
+#define HWCAP_VFPv4D16	(1 << 17)
+#define HWCAP_IDIVA	(1 << 18)
+#define HWCAP_IDIVT	(1 << 19)
+#define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 /*
-- 
1.7.0.4
