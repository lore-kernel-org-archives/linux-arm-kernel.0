From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 28 Apr 2016 11:18:57 -0400
Subject: [RFC 5/5] arm64: Gain VDSO unmap and remap powers
In-Reply-To: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
Message-ID: <1461856737-17071-6-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checkpoint/Restore In Userspace (CRIU) must be able to remap and unmap the
Virtual Dynamic Shared Object (VDSO) to be able to handle the changing
addresses that result from address space layout randomization. Now that the
support for this originally written for PowerPC has been moved to a generic
location and arm64 has adopted unsigned long for the type of mm->context.vdso,
simply opt-in to VDSO unmap and remap support.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..cbdce39 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,7 @@ config ARM64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VDSO_MAP
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
